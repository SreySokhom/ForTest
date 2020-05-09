import 'package:flutter/material.dart';
import 'package:prune_app/services/auth.dart';
import 'package:prune_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email, password, error;
  bool _obscureText = true;
  bool loading = false;

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
                padding:
                EdgeInsets.all(30.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.35,
                        ),
                        TextFormField(
                          validator: validateEmail,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                            prefixIcon: Icon(Icons.email, color: Colors.black,),
                          ),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (val.length < 6) {
                              return 'Must be more than 6 charater';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
//                          suffixIcon: GestureDetector(
//                            onTap: () {
//                              setState(() {
//                                _obscureText = !_obscureText;
//                              });
//                            },
//                            child: Icon(
//                              _obscureText
//                                  ? Icons.visibility_off
//                                  : Icons.visibility,
//                              semanticLabel: _obscureText
//                                  ? 'show password'
//                                  : 'hide password',
//                            ),
//                          ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                              prefixIcon: Icon(Icons.enhanced_encryption, color: Colors.black,)),
                          obscureText: _obscureText,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          height: 50,
                          child: RaisedButton(
                          color: Colors.orangeAccent[400],
                            child: Text(
                              'ログイン',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                await _auth.signInWithEmailAndPassword(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Invalid email or password';
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            color: Colors.orangeAccent[400],
                            child: Text(
                              '新規登録',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: (){
                              widget.toggleView();
                            },
                          ),
                        ),
                      ],
                    )
                )
            ),
            SizedBox(
//              height: 110,
            height: MediaQuery.of(context).size.height*0.097
            ),
            Container(
              color: Colors.orangeAccent[200],
              height: 58,
              child: Center(
                child: Text("登録せずに始める", style: TextStyle(
                  color: Colors.deepOrange,
                ),),
              ),
            )
          ],
        ),
      ),
    );
    }
  }
}
