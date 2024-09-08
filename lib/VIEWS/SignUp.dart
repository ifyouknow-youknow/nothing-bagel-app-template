import 'package:flutter/material.dart';
import 'package:edm_teachers_app/COMPONENTS/dropdown_view.dart';
import 'package:edm_teachers_app/COMPONENTS/future_view.dart';
import 'package:edm_teachers_app/VIEWS/Login.dart';
import 'package:edm_teachers_app/COMPONENTS/button_view.dart';
import 'package:edm_teachers_app/COMPONENTS/image_view.dart';
import 'package:edm_teachers_app/COMPONENTS/main_view.dart';
import 'package:edm_teachers_app/COMPONENTS/padding_view.dart';
import 'package:edm_teachers_app/COMPONENTS/text_view.dart';
import 'package:edm_teachers_app/COMPONENTS/textfield_view.dart';
import 'package:edm_teachers_app/FUNCTIONS/colors.dart';
import 'package:edm_teachers_app/FUNCTIONS/nav.dart';
import 'package:edm_teachers_app/MODELS/DATAMASTER/datamaster.dart';
import 'package:edm_teachers_app/MODELS/constants.dart';
import 'package:edm_teachers_app/MODELS/firebase.dart';
import 'package:edm_teachers_app/MODELS/screen.dart';
import 'package:edm_teachers_app/VIEWS/Dashboard.dart';

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

  List<dynamic> _districts = [];
  String _chosenDistrict = "";

  @override
  void initState() {
    super.initState();
    _init();
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

  Future<void> _init() async {
    try {
      final docs = await firebase_GetAllDocuments('${appName}_Districts');
      if (mounted) {
        setState(() {
          _districts = docs;
          if (docs.isNotEmpty) {
            _chosenDistrict = docs[0]['name'] as String;
          }
        });
      }
    } catch (e) {
      // Handle potential errors from firebase_GetAllDocuments
      print("Error fetching districts: $e");
    }
  }

  Future<void> onSignUp() async {
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

    setState(() {
      widget.dm.setToggleLoading(true);
    });

    try {
      final user = await auth_CreateUser(email, password);
      if (user != null) {
        final docs = await firebase_GetAllDocuments('${appName}_Districts');
        final districtId =
            docs.firstWhere((dist) => dist['name'] == _chosenDistrict)['id'];
        final success =
            await firebase_CreateDocument('${appName}_Teachers', user.uid, {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'districtId': districtId
        });
        if (success) {
          final signedIn = await widget.dm.checkUser();
          setState(() {
            widget.dm.setToggleLoading(false);
            widget.dm.setAlertTitle('Success!');
            widget.dm.setAlertText(
                'Your account has been successfully created. Please log in to complete your first sign-in.');
            widget.dm.setToggleAlert(true);
          });
          nav_Pop(context);
        } else {
          setState(() {
            widget.dm.setToggleLoading(false);
            widget.dm.alertSomethingWrong();
          });
        }
      } else {
        setState(() {
          widget.dm.setToggleLoading(false);
          widget.dm.alertSomethingWrong();
        });
      }
    } catch (e) {
      setState(() {
        widget.dm.setToggleLoading(false);
        widget.dm.alertSomethingWrong();
      });
      print("Error during sign up: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      PaddingView(
        paddingTop: 0,
        paddingBottom: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ButtonView(
                child: TextView(
                  text: 'back',
                  size: 16,
                  wrap: false,
                  weight: FontWeight.w500,
                ),
                onPress: () {
                  nav_Pop(context);
                }),
          ],
        ),
      ),
      const PaddingView(
        child: Center(
          child: ImageView(
            imagePath: 'assets/edm-fred.png',
            objectFit: BoxFit.contain,
          ),
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
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
                    text: 'District',
                  ),
                  if (_districts.isNotEmpty)
                    DropdownView(
                      defaultValue: _districts[0]['name'],
                      backgroundColor: Colors.white,
                      items: _districts
                          .map<String>((district) => district['name'] as String)
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _chosenDistrict = value;
                        });
                      },
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
                    color: Colors.black,
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
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
                  wrap: false,
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
