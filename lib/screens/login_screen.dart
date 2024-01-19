import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preference_task/screens/display_screen.dart';
import 'package:shared_preference_task/util/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late SharedPreferences logindata;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: ColorConstant.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 22, right: 40, bottom: 20),
                  child: Text(
                    'Welcome back! Glad to see you, Again!',
                    style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: TextFormField(
                    validator: (value) {
                      String emailPattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(emailPattern);
                      if (value.toString().isEmpty) {
                        return "Cannot be Empty";
                      } else if (!regExp.hasMatch(value!)) {
                        return "Email is Not Valid";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        filled: true,
                        fillColor: ColorConstant.lightGrey,
                        hintStyle: TextStyle(color: ColorConstant.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstant.borderColorE8ECF4,
                                width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: TextFormField(
                    validator: (value) {
                      String pattern =
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                      RegExp regExp = RegExp(pattern);
                      if (value.toString().isEmpty) {
                        return 'Password Cannot be Empty';
                      } else if (!regExp.hasMatch(value!)) {
                        return 'Enter Valid Password Format';
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passController,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        filled: true,
                        fillColor: ColorConstant.lightGrey,
                        hintStyle: TextStyle(color: ColorConstant.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstant.borderColorE8ECF4,
                                width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)))),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: null,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: ColorConstant.black),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)))),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xff1E232C))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var email = emailController.text;
                            logindata = await SharedPreferences.getInstance();

                            logindata.setString('email', email);
                            if (context.mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DisplayScreen(),
                                  ));
                            }
                          }
                          setState(() {
                            emailController.clear();
                            passController.clear();
                          });
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void getValue() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   var getName = prefs.getString('email');
  //   setState(() {
  //     nameValue = getName ?? '';
  //   });
  //   log(nameValue);
  // }
}
