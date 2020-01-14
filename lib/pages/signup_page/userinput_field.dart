import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  const UserInputField({
    Key key,
    @required TextEditingController usernameController,@required this.obscureTextRequired,@required this.labelText,
  }) : _userInputController = usernameController, super(key: key);

  final TextEditingController _userInputController;
  final bool obscureTextRequired;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
      child: TextFormField(
        obscureText: obscureTextRequired,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your $labelText';
          }
          return null;
        },
        controller: _userInputController,
      ),
    );
  }
}