import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'dart:convert';

// membuat model response
class loginResponse {
  String username;
  String name;
  String email;
  loginResponse(
      {required this.username, required this.name, required this.email});

  factory loginResponse.fromJson(Map<String, dynamic> json) => loginResponse(
      username: json['username'], name: json['name'], email: json['email']);
}

// membuat post login dari API
Future<loginResponse> createLogin(String username, String password) async {
  final map = {"username": username.trim(), "password": password.trim()};

  final Url = Uri.parse("http://10.0.2.2:5000/login");
  final response = await http.post(Url,
      body: jsonEncode(map), headers: {"content-type": "application/json"});

  if (response.statusCode == 200) {
    // jika server mengembalikan 200 OK (berhasil),
    // parse json
    return loginResponse.fromJson(jsonDecode(response.body));
  } else {
    // jika gagal (bukan  200 OK),
    // lempar exception
    throw Exception('Gagal load');
  }
}

//widget tampilkan profil response
Widget buildDataProfile(context, snapshot) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.all(5), child: Text("Login Berhasil")),
        Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [Text("username: "), Text(snapshot.data.username)],
            )),
        Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [Text("name: "), Text(snapshot.data.name)],
            )),
        Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [Text("email: "), Text(snapshot.data.email)],
            )),
      ],
    );

// tampilan widget utama
class myLoginPage extends StatefulWidget {
  const myLoginPage({Key? key}) : super(key: key);

  @override
  State<myLoginPage> createState() => _myLoginPageState();
}

class _myLoginPageState extends State<myLoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  Future<loginResponse>? logindata;

  // fung ketika button login di click
  void clickLoginButton() {
    setState(() {
      logindata = createLogin(usernameController.text.toString(),
          passwordController.text.toString());
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
                  Icons.mail,
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
                  clickLoginButton();

                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Login Dilakukan'),
                            content: FutureBuilder<loginResponse?>(
                                future: logindata,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.none) {
                                    return Container(
                                      child: Text("login gagal"),
                                    );
                                  } else {
                                    if (snapshot.hasData) {
                                      return buildDataProfile(
                                          context, snapshot);
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
                  "Login",
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
