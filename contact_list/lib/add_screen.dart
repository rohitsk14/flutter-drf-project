import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contactlist/card.dart';

class AddingScreen extends StatefulWidget {
  @override
  _AddingScreenState createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  final TextEditingController name_cntr = TextEditingController();
  final TextEditingController no_cntr = TextEditingController();
  Future<Cards> _futurecard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a contact',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: new InputDecoration(
                labelText: "Enter Email",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Email cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            TextField(
              controller: no_cntr,
            ),
            RaisedButton(
              onPressed: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                print(name_cntr.text);
                print(no_cntr.text);
                setState(() {
                  createCard(name_cntr.text, no_cntr.text);
                });
                name_cntr.clear();
                no_cntr.clear();
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }

  void createCard(String name, String number) async {
    String url = 'http://10.0.2.2:8000/viewset/details/';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String json = '{"name": "$name", "number": "$number"}';
    final http.Response response =
        await http.post(url, headers: headers, body: json);

    if (response.statusCode == 201) {
      print('Card created successfully');
    } else {
      throw Exception('Failed to create card.');
    }
  }
}
