import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'dart:convert';

// membuat model response
class userResponse {
  int userid;
  userResponse({required this.userid});

  factory userResponse.fromJson(Map<String, dynamic> json) =>
      userResponse(userid: json['userid']);
}

// membuat post user dari API
Future<userResponse> createUser(
    String username, String password, String name, String email) async {
  final map = {
    "username": username.trim(),
    "password": password.trim(),
    "name": name.trim(),
    "email": email.trim()
  };

  final Url = Uri.parse("http://10.0.2.2:5000/user");
  final response = await http.post(Url,
      body: jsonEncode(map), headers: {"content-type": "application/json"});

  if (response.statusCode == 200) {
    // jika server mengembalikan 200 OK (berhasil),
    // parse json
    return userResponse.fromJson(jsonDecode(response.body));
  } else {
    // jika gagal (bukan  200 OK),
    // lempar exception
    throw Exception('Gagal load');
  }
}

//widget tampilkan profil response
Widget buildUserId(context, snapshot) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.all(5),
            child: Text("Penambahan user Berhasil")),
        Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Text("userid: "),
                Text(snapshot.data.userid.toString())
              ],
            ))
      ],
    );

class myTambahPage extends StatefulWidget {
  const myTambahPage({Key? key}) : super(key: key);

  @override
  State<myTambahPage> createState() => _myTambahPageState();
}

class _myTambahPageState extends State<myTambahPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TambahPage(),
    );
  }
}

class TambahPage extends StatefulWidget {
  const TambahPage({Key? key}) : super(key: key);

  @override
  State<TambahPage> createState() => _TambahPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();

class _TambahPageState extends State<TambahPage> {
  Future<userResponse>? responseId;

  // fung ketika button login di click
  void clickTambahButton() {
    setState(() {
      responseId = createUser(
          usernameController.text.toString(),
          passwordController.text.toString(),
          nameController.text.toString(),
          emailController.text.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 253, 253, 253),
            Color.fromARGB(255, 82, 236, 141)
          ])),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "M-SEI",
              style: TextStyle(
                color: Color.fromARGB(255, 4, 214, 74),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("Magang Surya Energi Indotama",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                )),
            const SizedBox(
              height: 44,
            ),
            TextField(
              controller: usernameController,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.man,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: passwordController,
              style: TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: nameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.people,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              controller: emailController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 88.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color.fromRGBO(234, 67, 53, 1),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  clickTambahButton();

                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Penambahan Dilakukan'),
                            content: FutureBuilder<userResponse?>(
                                future: responseId,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.none) {
                                    return Container(
                                      child: Text("Penambahan gagal"),
                                    );
                                  } else {
                                    if (snapshot.hasData) {
                                      return buildUserId(context, snapshot);
                                    }
                                    return Container(
                                      child: Text("login gagal"),
                                    );
                                  }
                                }),
                            actions: [
                              TextButton(
                                  onPressed: () => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const HomePage();
                                        }))
                                      },
                                  child: Text('ok'))
                            ],
                          ));
                },
                child: const Text(
                  "Tambah User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
