import 'package:firebase_auth/firebase_auth.dart';
import 'package:trial/screens/home.dart';
import 'package:trial/screens/signup_exp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _email=TextEditingController();
    TextEditingController _password=TextEditingController();
    return Scaffold(
      body:
      Container(
        width: double.infinity,
        height: size.height,
        child: Column(
            children: [
              Image.asset(
                  "assets/images/top1.png",
                  width: size.width
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 35
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      labelText: "Email"
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _password,
                  decoration: InputDecoration(
                      labelText: "Password"
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.red
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: SizedBox(
                  width: 200,
                  child: FilledButton(
                      onPressed: () async {

                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: _email.text.toString(),
                              password: _password.text.toString()
                          );
                          if(FirebaseAuth.instance.currentUser !=null)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                          }
                          else
                          {

                          }

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      child: Text("LOGIN")
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text(
                    "Don't Have an Account? Sign up",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)
                    ),
                  ),
                ),
              ),
              Image.asset(
                  "assets/images/top1.png",
                  width: size.width
              ),

            ]),
      ),

    );
  }
}