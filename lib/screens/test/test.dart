import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prune_app/screens/test/quiz1.dart';

class Test extends StatefulWidget {
  String cid;
  Test({Key key, this.cid}): super(key:key);
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    print(widget.cid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: Border.all(color: const Color(0xFFFFFFFF)),
        leading: CupertinoNavigationBarBackButton(
          color: Colors.red,
          onPressed: () => Navigator.pop(context),
        ),
      ),
//        title: Text('Test'),
      body:  StreamBuilder(
        stream: Firestore.instance.collection('category_test').snapshots(),
        builder: (context, snp){
          for (var d in snp.data.documents)
            if(d['category_id'] == widget.cid){
              print(d['category_id']);
//              return Text(d['test_id']);
              return Container(
                margin: const EdgeInsets.all(15.0),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                        height: 50.0,
                        color: Colors.red,
                        onPressed:(){
                          Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => Quiz1()
                              )
                          );
                        },
                        child: new Text("Quiz",
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.white
                          ),)
                    ),

                  ],
                ),
              );
            }
          return Container(
            child: Center(
                child: GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Text("No Test", style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                  ),),
                )
            ),
          );
        },
      ),

    );
  }
//  startQuiz(String id){
//    print(id);
//    Navigator.push(
//        context,
//        CupertinoPageRoute(builder: (context) => Quiz1()
//        )
//    );
//  }
}
