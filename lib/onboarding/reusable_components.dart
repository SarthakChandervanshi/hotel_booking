import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {
        Key? key,
        required this.textEditingController,
        required this.prefixIcon,
        this.hintText,
        this.obscure,
        this.showSuffix,
      })
      : super(key: key);

  final TextEditingController textEditingController;
  final String? hintText;
  final Widget prefixIcon;
  bool? obscure;
  final bool? showSuffix;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      obscureText: widget.obscure ?? false,
      controller: widget.textEditingController,
      cursorColor: Colors.black,
      style: const TextStyle(
          color: Color(0xFF121212), fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          border: _border,
          focusedBorder: _border,
          errorBorder: _border,
          enabledBorder: _border,
          disabledBorder: _border,
          focusedErrorBorder: _border,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
              color: Color(0xFF1D1D1D),
            ),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints: const BoxConstraints.tightFor(),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: (widget.showSuffix ?? false) ? GestureDetector(
            onTap: () => setState((){
              widget.obscure = !(widget.obscure ?? false);
            }),
            child: (widget.obscure ?? false) ? const Icon(Icons.remove_red_eye_outlined,color: Color(0xFF1D1D1D),) : const Icon(Icons.remove_red_eye,color: Color(0xFF1D1D1D),),
          ) : const SizedBox(),
        ),
        suffixIconConstraints: const BoxConstraints.tightFor(),
      ),
    );
  }
}

