import '../utils/file_collection.dart';

class DropDownWidget extends StatelessWidget {
  final String? hintText;
  final String? dropDownTitle;
  final String? dropDownValue;
  final List? dropDownList;
  final Function? onChanged;
  final List<DropdownMenuItem<String>>? dropDownItem;

  const DropDownWidget(
      {super.key,
      this.hintText,
      this.dropDownTitle,
      this.dropDownValue,
      this.dropDownList,
      this.onChanged,
      this.dropDownItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: DropdownButton(
        underline: const SizedBox(),
        hint: hintText == null
            // refWatch.value?.selectProjectDropDownValue == null
            ? Text(
                dropDownTitle.toString(),
                style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            : Text(
                dropDownValue ?? '',
                style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
        isExpanded: true,
        iconSize: 30.0,
        style: const TextStyle(color: textColor, fontWeight: FontWeight.w400),
        items: dropDownItem,
        onChanged: onChanged as void Function(String?)?,
      ),
    );
  }
}
