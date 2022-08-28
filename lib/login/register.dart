import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudopertion/crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var firebase = FirebaseFirestore.instance.collection('mycrud');
  _registerUser() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        await firebase.doc(value.user!.uid).set({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Crud(
                      uid: value.user!.uid,
                    )));
      });
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmController.clear();
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: ht * 0.28, horizontal: 5),
            height: ht * 0.54,
            width: wd,
            child: Card(
              color: Colors.blue.shade400,
              elevation: 10,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 30),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      validator: (val) =>
                          val!.isEmpty == true ? "Name Can't be Empty" : null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) =>
                          val!.isEmpty == true ? "Email Can't be Empty" : null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Email"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      validator: (val) =>
                          val!.length <= 8 ? "Password must be 8 digit" : null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Password"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    child: TextFormField(
                      controller: confirmController,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Confirm-Password"),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            width: wd * 0.37,
                            height: 55,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Sign In"),
                            )),
                      ),
                      Expanded(
                        child: Container(
                            width: wd * 0.37,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _registerUser,
                              child: Text("Sign Up"),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
