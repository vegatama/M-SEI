import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// membuat post login dari API
class userList {
  int userid;
  String username;
  String name;
  String email;
  userList(
      {required this.userid,
      required this.username,
      required this.name,
      required this.email});

  factory userList.fromJson(Map<String, dynamic> json) => userList(
      userid: json['userid'],
      username: json['username'],
      name: json['name'],
      email: json['email']);
}

Future<List<userList>> fetchData() async {
  final Url = Uri.parse("http://10.0.2.2:5000/user");
  final response =
      await http.get(Url, headers: {"content-type": "application/json"});

  if (response.statusCode == 200) {
    // jika server mengembalikan 200 OK (berhasil),
    // parse json
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => userList.fromJson(data)).toList();
  } else {
    // jika gagal (bukan  200 OK),
    // lempar exception
    throw Exception('Gagal load');
  }
}

class myUserListPage extends StatefulWidget {
  const myUserListPage({Key? key}) : super(key: key);

  @override
  State<myUserListPage> createState() => _myUserListPageState();
}

class _myUserListPageState extends State<myUserListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: userListPage(),
    );
  }
}

class userListPage extends StatefulWidget {
  const userListPage({Key? key}) : super(key: key);

  @override
  State<userListPage> createState() => _userListPageState();
}

class _userListPageState extends State<userListPage> {
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
            Container(
              child: FutureBuilder<List<userList>>(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: FittedBox(
                        child: DataTable(
                          border: TableBorder.all(width: 1),
                          columnSpacing: 30,
                          columns: const [
                            DataColumn(label: Text('userid'), numeric: true),
                            DataColumn(label: Text('username')),
                            DataColumn(label: Text('name')),
                            DataColumn(label: Text('email')),
                          ],
                          rows: List.generate(
                            snapshot.data!.length,
                            (index) {
                              var data = snapshot.data![index];
                              return DataRow(cells: [
                                DataCell(
                                  Text(data.userid.toString()),
                                ),
                                DataCell(
                                  Text(data.username),
                                ),
                                DataCell(
                                  Text(data.name),
                                ),
                                DataCell(
                                  Text(data.email),
                                ),
                              ]);
                            },
                          ).toList(),
                          showBottomBorder: true,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const CircularProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
