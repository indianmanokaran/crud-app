import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/User.dart';
import '../services/userServices.dart';

class EditUser extends StatefulWidget {
  final User user;

  const EditUser({Key? key, required this.user}):super(key:key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var _usernameController = TextEditingController();
  var _userContactController = TextEditingController();
  var _userDescriptionController = TextEditingController();
  var _genderValue = "Male"; // Default gender value
  var _dobValue = DateTime.now(); // Default date of birth value
  var _userQualificationController = TextEditingController();
  var _userAgeController = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  bool _validateAge = false;
  bool _validateQualification = false;

  var _userServices = UserService();

  void initState() {
    // TODO: implement setState
    setState(() {
      _usernameController.text=widget.user.name??'';
      _userContactController.text=widget.user.contact??'';
      _userDescriptionController.text=widget.user.description??'';
      _dobValue = DateTime.parse(widget.user.dob ?? DateTime.now().toString());
      _userQualificationController.text=widget.user.qualification??'';
      _userAgeController.text=widget.user.age??'';
      _genderValue = widget.user.gender ?? "Male";
    });

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Sql Crud",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                'Update Users',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                  labelText: 'Name',
                  errorText: _validateName
                      ? 'Name value can\'t be empty:null'
                      : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userContactController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Contact',
                  labelText: 'Contact',
                  errorText: _validateContact
                      ? 'Contact value can\'t be empty:null'
                      : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userDescriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Description',
                  labelText: 'Description',
                  errorText: _validateDescription
                      ? 'Description value can\'t be empty:null'
                      : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RadioListTile<String>(
                title: const Text('Male'),
                value: "Male", // Set the value to "Male" for the male option
                groupValue: _genderValue,
                onChanged: (value) {
                  setState(() {
                    _genderValue = value ?? "Male";
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Female'),
                value: "Female", // Set the value to "Female" for the female option
                groupValue: _genderValue,
                onChanged: (value) {
                  setState(() {
                    _genderValue = value ?? "Male";
                  });
                },
              ),


              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _dobValue,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null && selectedDate != _dobValue) {
                    setState(() {
                      _dobValue = selectedDate;
                    });
                  }
                },
                child: Text(
                  'Select Date of Birth: ${DateFormat('yyyy-MM-dd').format(_dobValue)}', // Display the selected date
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userQualificationController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Qualification',
                  labelText: 'Qualification',
                  errorText: _validateQualification
                      ? 'Qualification value can\'t be empty:null'
                      : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userAgeController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Age',
                  labelText: 'Age',
                  errorText: _validateAge
                      ? 'Age value can\'t be empty:null'
                      : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        _usernameController.text.isEmpty
                            ? _validateName = true
                            : _validateName = false;
                        _userContactController.text.isEmpty
                            ? _validateContact = true
                            : _validateContact = false;
                        _userDescriptionController.text.isEmpty
                            ? _validateDescription = true
                            : _validateDescription = false;
                        _userQualificationController.text.isEmpty
                            ? _validateQualification = true
                            : _validateQualification = false;
                        _userAgeController.text.isEmpty
                            ? _validateAge = true
                            : _validateAge = false;
                      });
                      if (!_validateName &&
                          !_validateContact &&
                          !_validateDescription &&
                          !_validateQualification &&
                          !_validateAge) {
                        print("ready to save data");
                        var _user = User();
                        _user.id=widget.user.id;
                        _user.name = _usernameController.text;
                        _user.contact = _userContactController.text;
                        _user.description = _userDescriptionController.text;
                        _user.gender = _genderValue;
                        _user.dob = DateFormat('yyyy-MM-dd').format(_dobValue);
                        _user.qualification = _userQualificationController.text;
                        _user.age = _userAgeController.text;

                        // Assuming _userServices is correctly initialized
                        var result = await _userServices.UpdateUser(_user);
                        Navigator.pop(context, result);
                        print("Result: $result");
                      }
                    },
                    child: const Text('Update Data'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  TextButton(
                    onPressed: () {
                      _usernameController.text = '';
                      _userContactController.text = '';
                      _userDescriptionController.text = '';
                      _genderValue = "Male";
                      _dobValue = DateTime.now();
                      _userQualificationController.text = '';
                      _userAgeController.text = '';
                    },
                    child: const Text('Clear Data'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
