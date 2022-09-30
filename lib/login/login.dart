import 'package:crudopertion/crud.dart';
import 'package:crudopertion/login/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvalidation();
  }
  String? finaluid;
  Future getvalidation() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var obtaineduid = sharedPreferences.getString("uid");
    setState(() {
      finaluid = obtaineduid;
    });
  }
  void _login() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Crud(uid: value.user!.uid),
              ));
        }
        final SharedPreferences sharedpreference =
            await SharedPreferences.getInstance();
        sharedpreference.setString("uid", value.user!.uid);
      });
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wd = MediaQuery.of(context).size.width;
    return finaluid != null ? Crud(uid: "$finaluid",) :  Scaffold(
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: ht * 0.38, horizontal: 5),
            height: ht * 0.36,
            width: wd,
            child: Card(
              color: Colors.blue.shade400,
              elevation: 10,
              child: Column(
                children: [
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
                      decoration:const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Password"),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _login,
                              child: Text("Login In"),
                            )),
                      ),
                      Expanded(
                        child: Container(
                            height: 55,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Register()));
                              },
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
