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
import 'package:iic_app_template_flutter/MODELS/constants.dart';
import 'package:iic_app_template_flutter/MODELS/firebase.dart';
import 'package:iic_app_template_flutter/MODELS/screen.dart';
import 'package:iic_app_template_flutter/VIEWS/Dashboard.dart';

class SignUp extends StatefulWidget {
  final DataMaster dm;
  const SignUp({super.key, required this.dm});

  @override
  State<SignUp> createState() => _SignupState();
}

class _SignupState extends State<SignUp> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

//
  void onSignUp() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final password = _password.text;
    final confirmPassword = _confirmPassword.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        widget.dm.setAlertTitle('Missing Info');
        widget.dm.setAlertText("Please fill out all fields of this form.");
        widget.dm.setToggleAlert(true);
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        widget.dm.setAlertTitle('Password must match');
        widget.dm.setAlertText("Please make sure you enter the same password.");
        widget.dm.setToggleAlert(true);
      });
      return;
    }

    // GOOD TO GO!
    setState(() {
      widget.dm.setToggleLoading(true);
    });

    final user = await auth_CreateUser(email, password);
    if (user != null) {
      // STORE INFO AND NAVIGATE
      final success = await firebase_CreateDocument(
          '${appName}_Teachers',
          user.uid,
          {'firstName': firstName, 'lastName': lastName, 'email': email});
      if (success) {
        setState(() {
          widget.dm.setToggleLoading(false);
        });
        final signedIn = await widget.dm.checkUser();
        if (signedIn) {
          nav_PushAndRemove(context, Dashboard(dm: widget.dm));
        }
      } else {
        setState(() {
          widget.dm.setToggleLoading(false);
          widget.dm.alertSomethingWrong();
        });
        return;
      }
    } else {
      setState(() {
        widget.dm.setToggleLoading(false);
        widget.dm.alertSomethingWrong();
      });
      return;
    }
  }
//

  @override
  void initState() {
    super.initState();
    _password.addListener(() {
      setState(() {});
    });
    _confirmPassword.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      const PaddingView(
        child: Center(
          child: ImageView(
            imagePath: 'assets/edm-fred.png',
            objectFit: BoxFit.contain,
          ),
        ),
      ),
      SingleChildScrollView(
        child: SizedBox(
          width: getWidth(context),
          child: PaddingView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: 'Sign Up',
                  size: 30,
                  weight: FontWeight.w800,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextView(
                  text: 'First Name',
                ),
                TextfieldView(
                  controller: _firstNameController,
                  placeholder: 'ex. Jane',
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextView(
                  text: 'Last Name',
                ),
                TextfieldView(
                  controller: _lastNameController,
                  placeholder: 'ex. Doe',
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextView(
                  text: 'Email',
                ),
                TextfieldView(
                  controller: _emailController,
                  placeholder: 'ex. jdoe@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextView(
                  text: 'Password',
                ),
                TextfieldView(
                  controller: _password,
                  placeholder: 'must be 8 chars. min',
                  isPassword: true,
                ),
                if (_password.text.isNotEmpty && _password.text.length < 8)
                  const TextView(
                    text: 'Password must be 8 characters minimum.',
                    color: Colors.deepOrange,
                  ),
                const SizedBox(
                  height: 10,
                ),
                const TextView(
                  text: 'Confirm Password',
                ),
                TextfieldView(
                  controller: _confirmPassword,
                  placeholder: 'passwords must match..',
                  isPassword: true,
                ),
                if (_password.text.length >= 8 &&
                    _confirmPassword.text.isNotEmpty &&
                    _password.text != _confirmPassword.text)
                  const TextView(
                    text: 'Passwords do not match.',
                    color: Colors.red,
                  ),
                if (_password.text.isNotEmpty &&
                    _confirmPassword.text == _password.text)
                  const TextView(
                    text: 'Passwords match!',
                    color: Colors.green,
                  ),
              ],
            ),
          ),
        ),
      ),
      const Spacer(),
      PaddingView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonView(
                paddingBottom: 8,
                paddingTop: 8,
                paddingLeft: 18,
                paddingRight: 18,
                radius: 100,
                backgroundColor: hexToColor("#253677"),
                child: const TextView(
                  text: 'Sign Up',
                  color: Colors.white,
                  weight: FontWeight.w600,
                  size: 18,
                ),
                onPress: () {
                  onSignUp();
                })
          ],
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ]);
  }
}
