import 'package:flutter/material.dart';
import 'package:iic_app_template_flutter/COMPONENTS/button_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/image_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/main_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/padding_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/text_view.dart';
import 'package:iic_app_template_flutter/COMPONENTS/textfield_view.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/colors.dart';
import 'package:iic_app_template_flutter/FUNCTIONS/nav.dart';
import 'package:iic_app_template_flutter/MODELS/DATAMASTER/datamaster.dart';
import 'package:iic_app_template_flutter/MODELS/firebase.dart';
import 'package:iic_app_template_flutter/MODELS/screen.dart';
import 'package:iic_app_template_flutter/VIEWS/Dashboard.dart';
import 'package:iic_app_template_flutter/VIEWS/Signup.dart';

class Login extends StatefulWidget {
  final DataMaster dm;
  const Login({super.key, required this.dm});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //
  void onLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        widget.dm.setAlertTitle('Missing Info');
        widget.dm.setAlertText('Please provide a valid email and password.');
        widget.dm.setToggleAlert(true);
      });
      return;
    }

    setState(() {
      widget.dm.setToggleLoading(true);
    });
  }

  void init() async {
    final user = await auth_CheckUser();
    if (user != null) {
      nav_PushAndRemove(context, Dashboard(dm: widget.dm));
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      PaddingView(
        paddingTop: 0,
        paddingBottom: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonView(
                backgroundColor: hexToColor("#253677"),
                paddingBottom: 8,
                paddingTop: 8,
                paddingLeft: 18,
                paddingRight: 18,
                radius: 100,
                child: const TextView(
                  text: 'Sign Up',
                  color: Colors.white,
                  size: 18,
                  weight: FontWeight.w600,
                ),
                onPress: () {
                  nav_Push(context, SignUp(dm: widget.dm), () {
                    setState(() {});
                  });
                })
          ],
        ),
      ),
      Center(
        child: ImageView(
          imagePath: 'assets/edm-logo.png',
          objectFit: BoxFit.contain,
          width: getWidth(context) * 0.8,
          height: getHeight(context) * 0.2,
        ),
      ),
      const Spacer(
        flex: 1,
      ),
      SizedBox(
        width: getWidth(context),
        child: SingleChildScrollView(
          child: PaddingView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: 'Login',
                  size: 50,
                  weight: FontWeight.w800,
                  spacing: -1,
                ),
                const SizedBox(
                  height: 10,
                ),
                const PaddingView(
                  paddingTop: 2,
                  paddingBottom: 2,
                  paddingLeft: 0,
                  paddingRight: 0,
                  child: TextView(
                    text: 'Email',
                    weight: FontWeight.w500,
                    size: 16,
                  ),
                ),
                TextfieldView(
                  controller: _emailController,
                  placeholder: 'Email',
                ),
                const SizedBox(
                  height: 6,
                ),
                const PaddingView(
                  paddingTop: 2,
                  paddingBottom: 2,
                  paddingLeft: 0,
                  paddingRight: 0,
                  child: TextView(
                    text: 'Password',
                    weight: FontWeight.w500,
                    size: 16,
                  ),
                ),
                TextfieldView(
                  controller: _passwordController,
                  placeholder: 'Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonView(
                        paddingBottom: 8,
                        paddingTop: 8,
                        paddingLeft: 18,
                        paddingRight: 18,
                        radius: 100,
                        backgroundColor: hexToColor("#1985C6"),
                        child: const TextView(
                          text: 'Log In',
                          size: 18,
                          color: Colors.white,
                          weight: FontWeight.w600,
                        ),
                        onPress: () {
                          onLogin();
                        })
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
