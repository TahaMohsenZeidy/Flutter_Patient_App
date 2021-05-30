import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_app/main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Item selectedUser;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _imageName = "as.png";
  String _role, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        currentUser = user;
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    print(_role);
    if (_role == null){
      Fluttertoast.showToast(
          msg: 'Please Select a role',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.yellow
      );
    }
    else{
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        try {
          UserCredential user = await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
          if (user != null) {
            await _auth.currentUser.updateProfile(displayName: _role);
            String role = currentUser.displayName;
            if (role == "Doctor"){

            }
            // await Navigator.pushReplacementNamed(context,"/") ;

          }
        } catch (e) {
          showError(e.message);
          print(e);
        }
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Item> users = <Item>[
      const Item('Doctor',Icon(Icons.medical_services,color: Colors.blueAccent)),
      const Item('Patient',Icon(Icons.verified_user,color:  Colors.blueAccent)),
      const Item('Lab Assistant',Icon(Icons.assistant,color:  Colors.blueAccent,)),
      const Item('Radiologist',Icon(Icons.ac_unit,color:  Colors.blueAccent,)),
      const Item('Pharmacist',Icon(Icons.local_pharmacy,color:  Colors.blueAccent,))
    ];
    return Scaffold(
      appBar: AppBar (
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushReplacementNamed("start"),
        ),
      title: Text("back"),
      ),
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Image(
                image: AssetImage("assets/$_imageName"),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child:DropdownButton<Item>(
                        hint:  Text("Select Role"),
                        value: selectedUser,
                        onChanged: (Item Value) {
                          selectedUser = Value;
                          setState(() {
                            selectedUser;
                            if (selectedUser.name == "Doctor"){
                              _imageName = "onBoardDoc.png";
                            }
                            else if(selectedUser.name == "Patient"){
                              _imageName = "patients.jpg";
                            }
                            else if(selectedUser.name == "Lab Assistant") {
                              _imageName = "images/docprofile/doc3.png";
                            }
                            else if(selectedUser.name == "Radiologist") {
                              _imageName = "category7.png";
                            }
                            else{
                              _imageName = "category3.png";
                            }
                          _role = selectedUser.name;
                          });
                        },
                        items: users.map((Item user) {
                          return  DropdownMenuItem<Item>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                user.icon,
                                SizedBox(width: 10,),
                                Text(
                                  user.name,
                                  style:  TextStyle(color: Colors.blueAccent),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _email = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.length < 6)
                              return 'Provide Minimum 6 Character';
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: signUp,
                      child: Text('SignUp',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}


