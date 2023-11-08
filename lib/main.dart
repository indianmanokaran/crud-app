import 'package:flutter/material.dart';
import 'package:crud_flutter/screens/EditUser.dart';
import 'package:crud_flutter/screens/addUser.dart';
import 'package:crud_flutter/screens/viewUser.dart';
import 'package:crud_flutter/models/User.dart';
import 'package:crud_flutter/services/userServices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Operation',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userlist;
  List<User> allUsers = [];
  final _userService = UserService();

  getallusers() async {
    print('########################');
    var users = await _userService.readAllUsers();
    print('########################');
    print(users);
    setState(() {
      _userlist = (users as List<Map<String, dynamic>>)
          .map((user) => User(
        id: user['id'],
        name: user['name'],
        contact: user['contact'],
        description: user['description'],
        dob: user['dob'],
        age: user['age'],
        qualification: user['qualification'],
        gender: user['gender'],
      ))
          .toList();
      allUsers = List.from(_userlist);
    });
  }

  @override
  void initState() {
    super.initState();
    _userlist = [];
    getallusers();
  }

  _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  _deleteData(BuildContext context, id) {
    return showDialog(
      context: context,
      builder: (data) {
        return AlertDialog(
          title: Text(
            "Are You sure delete",
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                var result = await _userService.deleteUser(id);
                if (result != null) {
                  getallusers();
                  _showSuccessSnackbar('User deleted successfully');
                }
                Navigator.pop(context);
              },
              child: const Text('Delete'),
              style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.red),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
              style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.green),
            ),
          ],
        );
      },
    );
  }

  void searchUsersByName(String name) {
    setState(() {
      if (name.isEmpty) {
        // If the search name is empty, show all users.
        _userlist = List.from(allUsers);
      } else {
        _userlist = allUsers
            .where((user) => user.name?.toLowerCase().contains(name.toLowerCase()) == true)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Sqlite Crud',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? searchName = await showSearch<String>(
                context: context,
                delegate: UserSearchDelegate(_userlist),
              );
              if (searchName != null) {
                searchUsersByName(searchName);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: ()  {

            },
          ),
        ],
      ),
      body: _userlist.isEmpty
          ? Center(
        child: Text('No users available.'),
      )
          : ListView.builder(
        itemCount: _userlist.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewUser(
                      user: _userlist[index],
                    ),
                  ),
                );
              },
              leading: Icon(Icons.person),
              title: Text('Name: ${_userlist[index].name}'),
              subtitle: Text('Gender: ${_userlist[index].description}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUser(
                            user: _userlist[index],
                          ),
                        ),
                      ).then((data) {
                        if (data != null) {
                          getallusers();
                          _showSuccessSnackbar('USER Updated SUCCESSFULLY');
                        }
                      });
                    },
                    icon: Icon(Icons.edit, color: Colors.teal),
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteData(context, _userlist[index].id);
                    },
                    icon: Icon(Icons.delete, color: Colors.teal),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser())).then((data) {
            if (data != null) {
              getallusers();
              _showSuccessSnackbar('USER ADDED SUCCESSFULLY');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserSearchDelegate extends SearchDelegate<String> {
  final List<User> userList;

  UserSearchDelegate(this.userList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = userList
        .where((user) => user.name?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    return _buildSearchResults(results, context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = userList
        .where((user) => user.name?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    return _buildSearchResults(suggestions, context);
  }

  Widget _buildSearchResults(List<User> results, BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final user = results[index];
        return ListTile(
          title: Text(user.name ?? ''),
          onTap: () {
            close(context, user.name ?? '');
          },
        );
      },
    );
  }
}
