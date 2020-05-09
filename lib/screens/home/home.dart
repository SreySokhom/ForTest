import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prune_app/shared/background2.dart';
import 'viewlist.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width*1,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:50, bottom: 50),
                child: Center(
                  child: Text("Learning Subjects",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: Firestore.instance.collection('categories').snapshots(),
                builder: (context, snapshot){
                  if (!snapshot.hasData) return const Text("Loading...");
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return _customTextField(context, snapshot.data.documents[index], index);
                      }
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _customTextField(BuildContext context, DocumentSnapshot document, int index) {
  return GestureDetector(
    onTap: (){
      Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => ViewListScreen(id: document.documentID)
          )
      );
    },
    child: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height/11,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ClipPath(
              clipper: Background2(),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.primaries[index+6 % Colors.primaries.length],
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15),
                  child: Text(document['name']),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15,)
      ],
    ),
  );
}
