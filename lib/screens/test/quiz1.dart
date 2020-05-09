import 'package:flutter/material.dart';
import 'package:prune_app/screens/test/test.dart';
import 'package:flutter/cupertino.dart';

var finalScore = 0;
var questionNumber = 0;
var quiz = Test();

class Test {
  var questions = [
    "Question C",
    "Question A",
    "Question B",
    "Question D",
  ];

  var choices = [
    ["A", "B", "C", "D"],
    ["A", "B", "C", "D"],
    ["A", "B", "C", "D"],
    ["A", "B", "C", "D"]
  ];

  var correctAnswers = [
    "C", "A", "B", "D"
  ];
}

class Quiz1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new Quiz1State();
  }
}

class Quiz1State extends State<Quiz1> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(

            body:  Container(
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child:  Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(20.0)),
                  Container(
                    alignment: Alignment.centerRight,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Question ${questionNumber + 1} of ${quiz.questions.length}",
                          style:  TextStyle(
                              fontSize: 22.0
                          ),),

                        Text("Score: $finalScore",
                          style:  TextStyle(
                              fontSize: 22.0
                          ),)
                      ],
                    ),
                  ),

                  //image
                  Padding(padding: EdgeInsets.all(10.0)),
//
//                Image.asset(
//                  "images/${quiz.images[questionNumber]}.jpg",
//                ),

                  Padding(padding: EdgeInsets.all(10.0)),

                  Text(quiz.questions[questionNumber],
                    style: new TextStyle(
                      fontSize: 20.0,color: Colors.red,fontWeight: FontWeight.bold
                    ),),

                  Padding(padding: EdgeInsets.all(20.0)),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[

                      //button 1
                      MaterialButton(
                        minWidth: 500.0,
                        height: 68,
                        color: Colors.red,
                        onPressed: (){
                          if(quiz.choices[questionNumber][0] == quiz.correctAnswers[questionNumber]){
                            debugPrint("Correct");
                            finalScore++;
                          }else{
                            debugPrint("Wrong");
                          }
                          updateQuestion();
                        },
                        child:  Text(quiz.choices[questionNumber][0],
                          style:  TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                      ),
                      SizedBox(height: 10,),

                      //button 2
                      MaterialButton(
                        minWidth: 500.0,
                        height: 68,
                        color: Colors.red,
                        onPressed: (){

                          if(quiz.choices[questionNumber][1] == quiz.correctAnswers[questionNumber]){
                            debugPrint("Correct");
                            finalScore++;
                          }else{
                            debugPrint("Wrong");
                          }
                          updateQuestion();
                        },
                        child:  Text(quiz.choices[questionNumber][1],
                          style:  TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                      ),
                      SizedBox(height: 10,),
                      MaterialButton(
                        minWidth: 500.0,
                        height: 68,
                        color: Colors.red,
                        onPressed: (){

                          if(quiz.choices[questionNumber][2] == quiz.correctAnswers[questionNumber]){
                            debugPrint("Correct");
                            finalScore++;
                          }else{
                            debugPrint("Wrong");
                          }
                          updateQuestion();
                        },
                        child:  Text(quiz.choices[questionNumber][2],
                          style:  TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                      ),
                      SizedBox(height: 10,),
                      MaterialButton(
                        minWidth: 500.0,
                        height: 68,
                        color: Colors.red,
                        onPressed: (){

                          if(quiz.choices[questionNumber][3] == quiz.correctAnswers[questionNumber]){
                            debugPrint("Correct");
                            finalScore++;
                          }else{
                            debugPrint("Wrong");
                          }
                          updateQuestion();
                        },
                        child: new Text(quiz.choices[questionNumber][3],
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                      ),
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(10.0)),
                  new Container(
                      alignment: Alignment.bottomCenter,
                      child:   MaterialButton(
                          minWidth: 240.0,
                          height: 30.0,
                          color: Colors.red,
                          onPressed: resetQuiz,
                          child:  Text("Quit",
                            style:  TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                            ),)
                      )
                  ),
                ],
              ),
            ),

          )
      ),
    );
  }
  void resetQuiz(){
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void updateQuestion(){
    setState(() {
      if(questionNumber == quiz.questions.length - 1){
        Navigator.push(context,  MaterialPageRoute(builder: (context)=>  Summary(score: finalScore,)));

      }else{
        questionNumber++;
      }
    });
  }
}

class Summary extends StatefulWidget{
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white70,
        body:  Center(
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightGreen,
                width: 2,
              ),
              color: Colors.white70,
              borderRadius: BorderRadius.circular(12.0),

            ),
//            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${widget.score}/5',style:  TextStyle(
                    color: Colors.red,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold
                ),),
                Text("${widget.score} points",
                  style:  TextStyle(
                    color: Colors.red,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold
                  ),),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10,top: 250 ),
                  child: MaterialButton(
                    color: Colors.red,
                    onPressed: (){
                      questionNumber = 0;
                      finalScore = 0;
                      Navigator.pop(context);
                    },
                    child:  Text("OK",
                      style:  TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}