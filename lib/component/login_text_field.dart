import 'package:flutter/material.dart';
import 'package:calendar_scheduler/const/colors.dart';

class LoginTextField extends StatelessWidget {
  final FormFieldSetter<String?> onSaved;
  final FormFieldValidator<String?> validator;
  final String? hintText;
  final bool obscureText;

  const LoginTextField({
    required this.onSaved,
    required this.validator,
    this.obscureText = false,
    this.hintText,
    Key? key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      cursorColor: SECONDARY_COLOR,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: TEXT_FIELD_FILL_COLOR,
          ),
        ),
        // 포커스된 상태의 보더
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: SECONDARY_COLOR,
          ),
        ),
        // 오류 상태의 보더
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: ERROR_COLOR,
          ),
        ),
        // 포커스된 상태에서 에러가 났을 때 보더
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: ERROR_COLOR,
          ),
        ),
      ),
    );
  }
}