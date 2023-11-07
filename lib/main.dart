import 'package:crud_flutter/screens/EditUser.dart';
import 'package:crud_flutter/screens/addUser.dart';
import 'package:crud_flutter/screens/viewUser.dart';
import 'package:flutter/material.dart';

import 'models/User.dart';
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
      title: 'Flutter Demo',
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
              ))
          .toList();
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
            title: Text("Are You sure delete",style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 20),),
            actions: [
              TextButton(
                onPressed: () async{
                  var result=await _userService.deleteUser(id);
                  if (result != null) {
                    getallusers();
                    _showSuccessSnackbar(
                                  'user deleted sucessfully');
                    }
                  Navigator.pop(context);
                    },
                child: const Text('Delete'),
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.red),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('close'),
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.green),
              ),
            ],
          );
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
                                  )));
                    },
                    leading: Icon(Icons.person),
                    title: Text('Name: ${_userlist[index].name}'),
                    subtitle: Text('Contact: ${_userlist[index].contact}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      // To align trailing widgets at the end of the ListTile.
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUser(
                                          user: _userlist[index],
                                        ))).then((data) {
                              if (data != null) {
                                getallusers();
                                _showSuccessSnackbar(
                                    'USER Updated SUCCESSFULLY');
                              }
                            });
                            ;
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
                    // Add more properties as needed.
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUser()))
              .then((data) {
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
