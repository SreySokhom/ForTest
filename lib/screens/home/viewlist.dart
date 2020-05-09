import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prune_app/screens/home/view.dart';
import 'package:prune_app/screens/test/test.dart';
import 'package:prune_app/shared/loading.dart';

class ViewListScreen extends StatefulWidget {
  String id;
  ViewListScreen({Key key, this.id}): super(key:key);
  @override
  _ViewListScreenState createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          border: Border.all(color: const Color (0xFFFFFFFF)),
          leading: CupertinoNavigationBarBackButton(
            color: Colors.red,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: StreamBuilder(
              stream: Firestore.instance.collection('category_movie').snapshots(),
              builder: (context, snp) {
                if (snp.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snp.data.documents.length,
                      itemBuilder: (context, index) {
                        if (snp.data.documents[index]['category_id'] ==
                            widget.id) {
                          return getMovie(
                              context, snp.data.documents[index]["movie_id"],
                              widget.id);
                         }
                        return Container();
                      }
                  );
                }
                return Container();
              }
        )
        )
    );
  }
}

Widget getMovie(BuildContext context, String mid, String id){
  return StreamBuilder(
      stream: Firestore.instance.collection('movies').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          for(var document in snapshot.data.documents){
            if(document.documentID == mid){
              return ItemListView(context, document, id);
            }
          }
        }
        return Container();
      }
  );
}
Widget ItemListView ( BuildContext context, DocumentSnapshot doc, id) {
  return Column(
    children: <Widget>[
      GestureDetector(
        onTap:(){
          Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) =>
                  ViewScreen(
                    name: doc['name'],
                    desc: doc['desc'],
                    url: doc['url'],
                  )
              )
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400],
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width*1,
                child: Image.asset('assets/images/youtube.jpg'),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[400],
                    width: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 8),
                child: Text(doc['name'],style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.red,
                ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(doc['desc'],
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
                        child: Icon(Icons.favorite,color: Colors.red,),
                      ),
                      Text("1k" ,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
                        child: Icon(Icons.indeterminate_check_box,color: Colors.red,),
                      ),
                      Text("250" ,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8,bottom: 5,right: 8),
                child: ButtonTheme(
                  minWidth: 250.0,
                  height: 50.0,
                  buttonColor: Colors.red,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => Test(cid: id)
                            )
                        );
                      },
                      child: Text("TEST",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 2,)
    ],
  );
}
