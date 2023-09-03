import '../utils/file_collection.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final String? buttonName;
  final Function? onButtonPressed;
  final Color? color1;
  const BottomNavigationBarWidget(
      {super.key, this.buttonName, this.onButtonPressed, this.color1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: color1 ?? primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: TextButton(
          onPressed: onButtonPressed as void Function()?,
          child: Text(
            buttonName ?? 'Submit',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          )),
    );
  }
}
