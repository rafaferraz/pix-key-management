import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pix_key/controller/pix_key_controller.dart';
import 'package:pix_key/models/pix_key_model.dart';

class TextFieldPattern extends StatelessWidget {
  String label;
  String? initialValue;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  int? maxLines;
  TextEditingController? controller;

  TextFieldPattern({
    required this.label,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines,
    this.initialValue,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        decoration: InputDecoration(
          focusColor: const Color(0xff083863),
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xff083863),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff083863),
              width: .5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff083863),
            ),
          ),
        ),
        maxLines: maxLines ?? 1,
        inputFormatters: inputFormatters ?? [],
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validator,
      ),
    );
  }
}

class PixKeyTile extends StatelessWidget {
  PixKeyTile(
      {this.pixKey,
      required this.color,
      required this.controller,
      Key? key})
      : super(key: key);
  PixKey? pixKey;
  Color color = Colors.cyan[50]!;
  Color? colorText;
  PixKeyController controller;
  @override
  Widget build(BuildContext context) {
    colorText = color.computeLuminance() >= 0.5 ? Colors.black : Colors.white;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: Card(
        child: ListTile(
          tileColor: color,
          leading: CircleAvatar(
            backgroundColor: colorText,
            child: Icon(
              Icons.vpn_key,
              color: color,
            ),
          ),
          trailing: InkWell(
            child: CircleAvatar(
              backgroundColor: colorText,
              child: Icon(Icons.delete, color: Colors.red),
            ),
            onTap: ()async => await controller.deleteKey(pixKey!),
          ),
          title: Text(
            pixKey!.bank,
            style: TextStyle(
              color: colorText,
            ),
          ),
          subtitle: Text(
            pixKey!.key,
            style: TextStyle(
              color: colorText,
            ),
          ),
        ),
      ),
    );
  }
}
