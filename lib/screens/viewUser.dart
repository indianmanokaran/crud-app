import 'package:flutter/material.dart';

import '../models/User.dart';

class ViewUser extends StatefulWidget {
  final User user;
  const ViewUser({Key? key,required this.user}):super(key:key);

  @override
  State<ViewUser> createState() => _ViewuserState();
}

class _ViewuserState extends State<ViewUser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqlite Crud'),
      ),
      body: Container(
        child: Column(

          children: [
            SizedBox(height: 44),
            Text("Full Details",style: TextStyle(fontSize: 40,color: Colors.red,fontWeight: FontWeight.bold),),
            SizedBox(height: 44),
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [


                Text("Name:",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
                Text(widget.user.name??"",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),


              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Contact:",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
                Text(widget.user.contact??"",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Description:",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
                Text(widget.user.description??"",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
              ],
            )


          ],
        ),
      ),
    );
  }
}
