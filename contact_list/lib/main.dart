import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:contactlist/card.dart';
import 'package:backdrop/backdrop.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.white),
        primaryColor: Colors.orangeAccent,
      ),
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Cards> myModels;
  bool dataFetched = false;
  bool edit = false;
  int id;
  final TextEditingController name_cntr = TextEditingController();
  final TextEditingController no_cntr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<Cards> futureCards;
  @override
  void initState() {
    super.initState();
    fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text(
        'Contacts',
        style: GoogleFonts.pacifico(color: Colors.white),
      ),
      backLayer: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Add a contact',
              style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 10.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: name_cntr,
                    decoration: InputDecoration(
                      labelText: "Enter Name",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorColor: Colors.black38,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: no_cntr,
                    decoration: InputDecoration(
                      labelText: "Enter Number",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter number';
                      } else if (value.contains(RegExp(r'[a-z,A-Z]'))) {
                        return 'Must be a number';
                      }
                      return null;
                    },
                    style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorColor: Colors.black38,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    elevation: 5,
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: Colors.orangeAccent,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (edit == true) {
                          editCard(id, name_cntr.text, no_cntr.text);
                        } else {
                          createCard(name_cntr.text, no_cntr.text);
                        }
                        name_cntr.clear();
                        no_cntr.clear();
                      } else {
                        print('try again');
                        print(no_cntr.text.contains(RegExp(r'[0-9]')));
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      frontLayer: Container(
        child: Center(
          child: dataFetched == false
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: myModels.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        print('tile');
                        id = myModels[i].id;
                        tappedTile(myModels[i].name, myModels[i].number);
                        Backdrop.of(context).fling();
                      },
                      child: ListTile(
                        title: Text(myModels[i].name),
                        subtitle: Text(myModels[i].number),
                        trailing: GestureDetector(
                          child: Icon(Icons.delete),
                          onTap: () {
                            print('icon');
                            deleteCard(myModels[i].id);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      iconPosition: BackdropIconPosition.none,
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            print('toggled');
            name_cntr.clear();
            no_cntr.clear();
          },
          child: BackdropToggleButton(
            icon: AnimatedIcons.event_add,
          ),
        ),
      ],
    );
  }

  void fetchCards() async {
    final response = await http.get('http://10.0.2.2:8000/viewset/details/');
    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      print('cards fetched');
      setState(() {
        dataFetched = true;
        myModels = (json.decode(response.body) as List)
            .map((i) => Cards.fromJson(i))
            .toList();
      });
    } else {
      throw Exception('Failed to load cards');
    }
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
      fetchCards();
    } else {
      throw Exception('Failed to create card.');
    }
  }

  void editCard(int id, String name, String number) async {
    String url = 'http://10.0.2.2:8000/viewset/details/$id/';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String json = '{"name": "$name", "number": "$number"}';
    final http.Response response =
        await http.put(url, headers: headers, body: json);

    if (response.statusCode == 200) {
      print('Card edited successfully');
      edit = false;
      fetchCards();
    } else {
      throw Exception('Failed to edit card.');
    }
  }

  void deleteCard(int id) async {
    String url = 'http://10.0.2.2:8000/viewset/details/$id/';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final http.Response response = await http.delete(url, headers: headers);

    if (response.statusCode == 204) {
      print('Card deleted successfully');
      fetchCards();
    } else {
      throw Exception('Failed to delete card.');
    }
  }

  void tappedTile(String name, String number) {
    name_cntr.text = name;
    no_cntr.text = number;
    edit = true;
  }
}
