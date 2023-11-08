import 'package:flutter/material.dart';
import '../models/User.dart';

class ViewUser extends StatefulWidget {
  final User user;

  const ViewUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewuserState();
}

class _ViewuserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'User Data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DataTable(
                columns: [
                  DataColumn(
                    label: Text('Field', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Name')),
                    DataCell(Text(widget.user.name ?? '')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Contact')),
                    DataCell(Text(widget.user.contact ?? '')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Description')),
                    DataCell(Text(widget.user.description ?? '')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Gender')),
                    DataCell(Text(widget.user.gender ?? '')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Age')),
                    DataCell(Text(widget.user.age ?? '')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Qualifications')),
                    DataCell(Text(widget.user.qualification ?? '')),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
