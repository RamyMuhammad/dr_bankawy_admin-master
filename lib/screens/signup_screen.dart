// ignore_for_file: deprecated_member_use, unused_local_variable, must_be_immutable, non_constant_identifier_names

import 'package:dr_bankawy/provider/modelHud.dart';
import 'package:dr_bankawy/screens/admin/adminHome.dart';
import 'package:dr_bankawy/screens/login_screen.dart';
import 'package:dr_bankawy/widgets/custom_textfield.dart';
import 'package:dr_bankawy/widgets/cutsom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:dr_bankawy/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  final _auth = Auth();

  final TextEditingController username_Controller = TextEditingController();
  final TextEditingController email_Controller = TextEditingController();
  final TextEditingController password_Controller = TextEditingController();

  SignupScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: kThiredColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: height * 0.1,
              ),
              const CustomLogo(),
              // SizedBox(
              //   height: height * 0.1,
              // ),
              Container(
                decoration: const BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .05,
                    ),
                    CustomTextField(
                      controller: username_Controller,
                      hint: 'اسم المستخدم',
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    CustomTextField(
                      controller: email_Controller,
                      hint: 'البريد الالكتروني',
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: password_Controller,
                        obscureText: true,
                        cursorColor: kThiredColor,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          hintText: "كلمة المرور",
                          filled: true,
                          fillColor: kThiredColor,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    // CustomTextField(
                    //   controller: password_Controller,
                    //   hint: 'كلمة المرور',
                    //   maxLines: 1,
                    // ),
                    SizedBox(
                      height: height * .05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Builder(
                        builder: (context) => FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () async {
                            final modelhud =
                                Provider.of<ModelHud>(context, listen: false);
                            modelhud.changeisLoading(true);
                            if (_globalKey.currentState.validate()) {
                              _globalKey.currentState.save();
                              try {
                                final authResult = await _auth.signUp(
                                    email_Controller.text.trim(),
                                    password_Controller.text.trim());
                                modelhud.changeisLoading(false);
                                Navigator.pushNamed(context, AdminHome.id);
                              } on PlatformException catch (e) {
                                modelhud.changeisLoading(false);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(e.message),
                                ));
                              }
                            }
                          },
                          color: kSecondaryColor,
                          child: const Text(
                            'انشاء حساب',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'لا تمتلك حساب ؟',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'الدخول',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
