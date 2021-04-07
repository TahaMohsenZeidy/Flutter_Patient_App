import 'dart:ffi';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blueAccent,
                    Colors.lightBlueAccent,
                  ],
                )),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Sign Up',style: TextStyle(
                    fontSize: 50.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 22.0),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'User Email',
                          contentPadding: EdgeInsets.all(16.0),
                          prefixIcon: Icon(Icons.email,color: Colors.blue,)
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 22.0),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'User stuff',
                          contentPadding: EdgeInsets.all(16.0),
                          prefixIcon: Icon(Icons.access_alarm,color: Colors.blue,)
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 25.0),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: 'User Password',
                          contentPadding: EdgeInsets.all(16.0),
                          prefixIcon: Icon(Icons.lock,color: Colors.blue,)
                      ),
                      obscureText: true,
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){},
                    shape: StadiumBorder(),
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Sign Up",style: TextStyle(fontSize: 22.0),),
                    padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 80.0),
                    elevation: 0.0,

                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}