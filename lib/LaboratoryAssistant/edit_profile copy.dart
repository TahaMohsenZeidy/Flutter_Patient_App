import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/main.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isObscurePassword = true;
  Map label_vlaue = Map<String, String>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Edit Profile'),
        // ignore: missing_required_param
        leading:IconButton(
          icon: Icon(
            Icons.arrow_back,
            color : Colors.white,
          ),
          onPressed: () {} ,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {}
               )
          ],
      ),
      body: Container(
        padding: EdgeInsets.only(left:15, top:10, right:15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView (
            children: [
              Center(
                child:Stack (
                  children:[
                    Container(
                      width:130,
                      height:130,
                      decoration: BoxDecoration(
                        border : Border.all(width:4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/blue.png"
                             )   
                          )
                        )
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height:40,
                        width:40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white
                          ),
                          color: Colors.blue
                         ),
                         child: Icon(
                           Icons.edit,
                           color: Colors.white
                         ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height : 30),
              buildTextField("name","First&Last Name", false),
              buildTextField("email","Email", false),
              buildTextField("pass","Password", true),
              buildTextField("phone","Phone", false),
              buildTextField("spec","Speciality", false),
              buildTextField("exp","Experience Years", false),
              buildTextField("desc","Description", false),
              SizedBox(height:30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("CANCEL" ,style: TextStyle(
                      fontSize:15,
                      letterSpacing: 2,
                      color: Colors.black
                    )),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal:50),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))
                    ),
                   ),
                   ElevatedButton(
                     onPressed:() {
                       usersRef.doc(currentUser.uid).set({
                         "username": label_vlaue["name"],
                         "email": label_vlaue["name"],
                         "password": label_vlaue["pass"],
                         "phone": label_vlaue["phone"],
                         "experience": label_vlaue["exp"],
                         "description": label_vlaue["desc"],
                         "speciality": label_vlaue["spec"],
                       });

                     },
                      child: Text ("SAVE", style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white
                      )),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                      )
                ],
              )


            ],
          ),

        ),
      ),
    );
  }
  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom :30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword :false,
        decoration:InputDecoration(
          suffixIcon:  isPasswordTextField ?
          IconButton(
            icon: Icon(Icons.remove_red_eye, color:Colors.grey),
            onPressed:() {
              setState(() {
                isObscurePassword =!isObscurePassword;
              });
            },
          ):null,
          contentPadding: EdgeInsets.only(bottom:5),
          labelText: placeholder,
          hintStyle: TextStyle(
            fontSize:16,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          )
        ),
          onSubmitted: (value) {
            print("The value entered is : $value");
            label_vlaue.putIfAbsent(labelText, () => value);
            print(label_vlaue);
          }
          
      ),
    );
  }
}