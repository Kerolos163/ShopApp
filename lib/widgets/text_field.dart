import 'package:flutter/material.dart';

import '../Theme/theme.dart';


Widget TEXTFIELD(
  TextEditingController varname,
  var kbt,//keyboard type
  String label,//label
  String hint,//hint
  Widget icon,//icon
  bool ot,//text visible
)
{
  return Padding(
    padding:const EdgeInsets.symmetric(vertical: 7,horizontal: 5),
    child: TextFormField(
      validator: (value) {
      if (value == null || value.isEmpty) {
      return 'Please Enter $label';
    }
    return null;
      },
      cursorColor: primaryClr,
      obscureText: ot,
      controller: varname,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: label,
        labelStyle: Titlestyle,
        hintText: hint,
        hintStyle: Body2lestyle,
        suffixIcon: icon,
        suffixIconColor: primaryClr,
        // focusColor: primaryClr,
        focusedBorder:  OutlineInputBorder( 
          borderRadius:BorderRadius.circular(20),
            borderSide:const BorderSide(
          color: primaryClr,
          width: 1,
        )),
        
      ), 
      keyboardType: kbt,
    ),
  );
}
