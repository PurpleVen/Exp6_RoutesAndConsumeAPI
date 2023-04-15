import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user_name;

  // void getData() async {
  //   await Future.delayed(Duration(seconds: 3), (){
  //     priprofilent("Response after 3 second");
  //   });
  //
  //   print("Within getData ...after Future Delayed");
  //
  // }

  void getData() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/users/1');
    Response response = await get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      setState(() {
        user_name = jsonResponse['name'];
      });
      print(user_name);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      user_name = "Default_Name";
    }
  }

  int dataAccessLevel = 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Within Init State Function");
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Within Dispose Function");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Card"),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blue],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Divider(
                color: Colors.red[850],
                height: 30.0,
                thickness: 2.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.account_circle_sharp,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Name Fetched From API",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "$user_name",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.desktop_windows,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Data Access Level",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "$dataAccessLevel",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/dashboard',
                        arguments: {
                          'name': "$user_name",
                        });
                  },
                  child: Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            dataAccessLevel += 1;
          });
        },
        child: Text("+"),
        backgroundColor: Colors.grey[850],
      ),
    );
  }
}
