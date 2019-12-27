import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';
import 'package:message_app/pages/signup_page.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key key}) : super(key: key);

  @override
  ProfileFormState createState() {
    return ProfileFormState();
  }

}

class ProfileFormState extends State<ProfileWidget> {

  final _formKey = GlobalKey<FormState>();
  String name = "naveen";
  final _usernameController = TextEditingController(text: "Naveen");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: AvatarLetter(
                size: 80,
                backgroundColor: Colors.lightBlue,
                textColor: Colors.white,
                fontSize: 40,
                upperCase: true,
                numberLetters: 1,
                letterType: LetterType.Circular,
                text: name,
                backgroundColorHex: null,
                textColorHex: null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Username",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              controller: _usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: RaisedButton(
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, SignupPage.routeName);
                },
                child: Text('Log Out'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}