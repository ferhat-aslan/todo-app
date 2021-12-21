import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/pages/todo_list_page.dart';

class anasayfa extends StatefulWidget {
  const anasayfa({Key? key}) : super(key: key);

  @override
  _anasayfaState createState() => _anasayfaState();
}

class _anasayfaState extends State<anasayfa> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   shape: Border(bottom: BorderSide(color: Colors.orange, width: 4)),
        //   backgroundColor: Colors.black,
        //   elevation: 0,
        //   centerTitle: true,
        //   title: Text('Anasayfa'),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           FirebaseAuth.instance.signOut().then((value) {
        //             Navigator.pushAndRemoveUntil(
        //                 context,
        //                 MaterialPageRoute(builder: (context) => girisEkrani()),
        //                 (route) => false);
        //           });
        //         },
        //         icon: Icon(Icons.exit_to_app)),
        //   ],
        // ),
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 3,
          child: TodoListPage(),
        ),
      ),
    );
  }
}
