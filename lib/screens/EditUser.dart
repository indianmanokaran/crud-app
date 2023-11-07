import 'package:flutter/material.dart';

import '../models/User.dart';
import '../services/userServices.dart';

class EditUser extends StatefulWidget {
  final User user;

  const EditUser({Key? key, required this.user}):super(key:key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var _usernamecontroller=TextEditingController();
  var _usercontactcontroller=TextEditingController();
  var _userdescriptioncontroller=TextEditingController();
  bool _validateName=false;
  bool _validateContact=false;
  bool _validateDescription=false;
  var _userServices = UserService();
  @override
  void initState() {
    // TODO: implement setState
 setState(() {
   _usernamecontroller.text=widget.user.name??'';
   _usercontactcontroller.text=widget.user.contact??'';
   _userdescriptioncontroller.text=widget.user.description??'';
 });

  super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Sql Crud",style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),

      ),
      body:SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(


            children: [

              Text('Edit Users',style: TextStyle(
                  fontSize: 40,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500
              ),
              ),

              TextField(
                controller: _usernamecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                  labelText: 'Name',
                  errorText: _validateName? 'Name value can\'t be empty:null' :null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _usercontactcontroller,
                decoration: InputDecoration(
                  border:const OutlineInputBorder(),
                  hintText: 'Enter Contact',
                  labelText: 'Contact',
                  errorText: _validateContact? 'Contact value can\'t be empty:null' :null,

                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userdescriptioncontroller,
                decoration: InputDecoration(
                  border:const OutlineInputBorder(),
                  hintText: 'Enter Description',
                  labelText: 'Description',
                  errorText: _validateDescription? 'Description value can\'t be empty:null' :null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(

                children: [

                  TextButton(onPressed: () async{
                    setState(() {
                      _usernamecontroller.text.isEmpty?_validateName=true:_validateName=false;
                      _usercontactcontroller.text.isEmpty?_validateContact=true:_validateContact=false;
                      _userdescriptioncontroller.text.isEmpty?_validateDescription=true:_validateDescription=false;


                    });
                    if(_validateName==false&&_validateContact==false&&_validateDescription==false){
                      print("ready to save data");
                      var _user = User();
                      _user.id=widget.user.id;
                      _user.name = _usernamecontroller.text;
                      _user.contact = _usercontactcontroller.text;
                      _user.description = _userdescriptioncontroller.text;

                      // Assuming _userServices is correctly initialized
                      var result = await _userServices.UpdateUser(_user);
                      Navigator.pop(context,result);
                      print("Result: $result");
                    }
                  },
                    child: const Text('Update Data'),
                    style:TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.teal,
                        textStyle: const TextStyle(fontSize: 15)
                    ) ,),
                  const SizedBox(
                    width: 20.0,
                  ),
                  TextButton(onPressed: (){
                    _usernamecontroller.text='';
                    _usercontactcontroller.text='';
                    _userdescriptioncontroller.text='';
                  },
                    child: const Text('clear Data'),
                    style:TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 15)
                    ) ,),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
