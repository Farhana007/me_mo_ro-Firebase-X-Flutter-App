import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_mo_ro/views/common_widger_screen.dart';
import 'package:me_mo_ro/views/home_sc.dart';
import 'package:me_mo_ro/views/signup_sc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import '../auth/firebaseAuth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool loading = false;

class _LoginScreenState extends State<LoginScreen> {
  // textEditing controller for email and password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //disposing the controller
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customTextField(
                //email field
                hint: "email",
                controller: _emailController,
                obs: false,
              ),
              customTextField(
                //password field
                hint: "password",
                controller: _passwordController,
                obs: true,
              ),
              50.heightBox,

              //login Button
              GestureDetector(
                onTap: () async {
                  //checking the condition if pass and email field is filed
                  if (_emailController.text == "" ||
                      _passwordController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("email and password required"),
                        backgroundColor: Colors.red,
                      ),
                    );

                    //if all conditions are filled the Login User
                  } else {
                    setState(() {
                      loading = true;
                    });
                    User? result = await AuthClass().loginUser(
                        _emailController.text,
                        _passwordController.text,
                        context);

                    //if user has data then logIn and Move to the Next Screen

                    if (result != null) {
                      Get.to(() => HomeScreen());
                    }
                    setState(() {
                      loading = false;
                    });
                  }
                },
                child: loading
                    ? CircularProgressIndicator()
                    : customButton(
                        title: "Login",
                      ),
              ),
              20.heightBox,
              InkWell(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },

                  //button to go to SignUp screen is User isn't registered
                  child: "Don't Have Account? SignUp"
                      .text
                      .size(16)
                      .semiBold
                      .black
                      .make())
            ],
          ),
        )
                .box
                .height(MediaQuery.of(context).size.height * 0.4)
                .width(MediaQuery.of(context).size.width * 0.7)
                .color(
                  Color.fromARGB(255, 57, 224, 242),
                )
                .rounded
                .shadow
                .make()));
  }
}
