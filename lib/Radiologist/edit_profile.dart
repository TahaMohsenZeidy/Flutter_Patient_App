import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isObscurePassword = true;
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
                          image: NetworkImage(
                           ' https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_960_720.jpg'
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
              buildTextField("mery","Username", false),
              buildTextField("mery@enis.tn","Email", false),
              buildTextField("*****","Password", true),
              buildTextField("Sfax","Location of laboratory ", false),
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
                     onPressed:() {},
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
      ),
    );
  }
}