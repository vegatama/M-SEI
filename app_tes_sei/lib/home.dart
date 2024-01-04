import 'package:flutter/material.dart';
import 'login.dart';
import 'tambah-user.dart';
import 'list-user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: selectPage(),
    );
  }
}

class selectPage extends StatefulWidget {
  const selectPage({Key? key}) : super(key: key);

  @override
  State<selectPage> createState() => _selectPageState();
}

class _selectPageState extends State<selectPage> {
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
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color.fromRGBO(234, 67, 53, 1),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const myLoginPage();
                  }));
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
            const SizedBox(
              height: 44,
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const myUserListPage();
                  }));
                },
                child: const Text(
                  "List User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 44,
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const myTambahPage();
                  }));
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
