import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:me_mo_ro/views/common_widger_screen.dart';
import 'package:me_mo_ro/views/home_sc.dart';
import 'package:me_mo_ro/views/login_sc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:me_mo_ro/auth/firebaseAuth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

bool loading = false;

// textediting controllers
class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _userNameController = TextEditingController();

  //disposing the controllers
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _confirmPassController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _userNameController.dispose();
  }

  // creating FirebaseDatabase instance  to store data in firebase

  final databaseRef = FirebaseDatabase.instance.ref('userd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //username field
              customTextField(
                hint: "set a username",
                controller: _userNameController,
                obs: false,
              ),

              //email field
              customTextField(
                hint: "enter email",
                controller: _emailController,
                obs: false,
              ),
              customTextField(
                //password field
                hint: "enter password",
                controller: _passController,
                obs: false,
              ),
              customTextField(
                //confirmpassword field
                hint: "confirm password",
                controller: _confirmPassController,
                obs: true,
              ),
              50.heightBox,

              // Signup Button
              GestureDetector(
                onTap: () async {
                  //database store function

                  int id = DateTime.now().millisecond;

                  databaseRef.child(id.toString()).set({
                    'id': id.toString(),
                    'username': _userNameController.text.toString(),
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("UserName  Added"),
                        backgroundColor: Color.fromARGB(255, 54, 238, 244),
                      ),
                    );
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });

                  //signup function

                  // conditions to check if all fields are filled
                  if (_emailController.text == "" ||
                      _passController.text == "" ||
                      _userNameController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("all fields required"),
                        backgroundColor: Colors.red,
                      ),
                    );

                    //conditions to check if password and confirmpassword match
                  } else if (_passController.text !=
                      _confirmPassController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("password doesn't match"),
                        backgroundColor: Colors.red,
                      ),
                    );

                    //if everything is field then Register the user
                  } else {
                    setState(() {
                      loading = true;
                    });

                    //User Register Function
                    User? result = await AuthClass().registerUser(
                        _emailController.text,
                        _passController.text,
                        _confirmPassController.text,
                        _userNameController.text,
                        context);

                    if (result != null) {
                      Get.to(() => HomeScreen());
                    }
                    setState(() {
                      loading = false;
                    });
                  }
                },

                //while user is being register showing loading indicator
                child: loading
                    ? CircularProgressIndicator()
                    : customButton(
                        title: "Signup",
                      ),
              ),
              20.heightBox,
              InkWell(
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },

                  //button to go to login if already registered
                  child: "Already Have Account? Login"
                      .text
                      .size(16)
                      .semiBold
                      .black
                      .make())
            ],
          ),
        )
                .box
                .height(MediaQuery.of(context).size.height * 0.6)
                .width(MediaQuery.of(context).size.width * 0.7)
                .color(
                  Color.fromARGB(255, 57, 224, 242),
                )
                .rounded
                .shadow
                .make()));
  }
}
