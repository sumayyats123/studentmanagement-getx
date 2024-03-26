import 'package:flutter/material.dart';

class CustomTextFielddWidget extends StatelessWidget {
  const CustomTextFielddWidget({
    super.key,
    required this.controller,
    this.inputType,
    this.hintText,
    this.labelText,
    this.prefixicon,
    this.maxLength,
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final TextInputType? inputType;
  final String? hintText;
  final String? labelText;
  final IconData? prefixicon;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 16.0),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        maxLength: maxLength,
       decoration: InputDecoration(
          
          labelText: labelText,
          prefixIcon: prefixicon!=null ?Icon(prefixicon):null,
          fillColor: const Color.fromARGB(255, 158, 186, 235),
        
          border:  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color:  Color.fromARGB(255, 158, 186, 235),)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color:  Color.fromARGB(255, 158, 186, 235),),
              borderRadius: BorderRadius.circular(15),),
        ),
        controller: controller,
        keyboardType: inputType,
      ),
    );
  }
}
