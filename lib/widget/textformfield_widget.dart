import '../utils/file_collection.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  final Function? onChanged;
  final bool? readOnly;
  final int? maxLines;
  final TextInputType? keyboardType;
  const TextFormFieldWidget(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.obscureText,
      this.controller,
      this.onChanged,
      this.readOnly,
      this.maxLines,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        maxLines: maxLines ?? 1,
        readOnly: readOnly ?? false,
        controller: controller,
        onChanged: onChanged as void Function(String)?,
        style: const TextStyle(fontSize: 18),
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          isDense: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: hintText ?? '',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 3, color: secondaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: secondaryColor, width: 2.0)),
          suffixIcon: suffixIcon ?? const SizedBox(),
        ));
  }
}
