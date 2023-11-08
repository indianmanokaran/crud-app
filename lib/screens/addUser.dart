import 'package:crud_flutter/models/User.dart';
import 'package:flutter/material.dart';
import 'package:crud_flutter/services/userServices.dart';
import 'package:intl/intl.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
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
                'Add New Users',
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
                  errorText:
                      _validateName ? 'Name value can\'t be empty:null' : null,
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
                value: "Male",
                groupValue: _genderValue,
                onChanged: (value) {
                  setState(() {
                    _genderValue = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Female'),
                value: "Female",
                groupValue: _genderValue,
                onChanged: (value) {
                  setState(() {
                    _genderValue = value!;
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
                  'Select Date of Birth: ${DateFormat('yyyy-MM-dd').format(_dobValue)}',
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
                  errorText:
                      _validateAge ? 'Age value can\'t be empty:null' : null,
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
                        // Check if the age is empty, not a valid number, or less than 18
                        if (_userAgeController.text.isEmpty ||
                            (int.tryParse(_userAgeController.text) ?? 0) < 18) {
                          _validateAge = true;
                        } else {
                          _validateAge = false;
                        }

                      });
                      if (!_validateName &&
                          !_validateContact &&
                          !_validateDescription &&
                          !_validateQualification &&
                          !_validateAge) {
                        print("ready to save data");
                        var _user = User();
                        _user.name = _usernameController.text;
                        _user.contact = _userContactController.text;
                        _user.description = _userDescriptionController.text;
                        _user.gender = _genderValue;
                        _user.dob = DateFormat('yyyy-MM-dd').format(_dobValue);
                        _user.qualification = _userQualificationController.text;
                        _user.age = _userAgeController.text;

                        // Assuming _userServices is correctly initialized
                        var result = await _userServices.SaveUser(_user);
                        Navigator.pop(context, result);
                        print("Result: $result");
                      }
                    },
                    child: const Text('Save Data'),
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
