import '../../utils/file_collection.dart';

class SearchWidgetTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function? onChanged;
  const SearchWidgetTextField({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: TextFormField(
            maxLength: 10,
            keyboardType: TextInputType.text,
            controller: controller,
            onChanged: onChanged as void Function(String)?,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              isDense: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Search Code',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(width: 3, color: secondaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: secondaryColor, width: 2.0)),
              suffixIcon: InkWell(
                onTap: () {
                  context.pushNamed(RouteNames.scanQR);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  width: 50,
                  height: 40,
                  child: const Icon(Icons.photo_camera,
                      size: 24, color: secondaryColor),
                ),
              ),
            ))
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(10.0, 12, 10, 12),
        //   child: Row(children: [
        //     const Icon(Icons.search, color: primaryColor, size: 28),
        //     const SizedBox(width: 10),
        //     const Text(
        //       'Search',
        //       style: TextStyle(
        //         color: secondaryColor,
        //         fontSize: 18.0,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //     const Spacer(),
        // InkWell(
        //   onTap: () {
        //     context.pushNamed(RouteNames.scanQR);
        //   },
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       color: primaryColor,
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(8),
        //       ),
        //     ),
        //     width: 50,
        //     height: 36,
        //     child: const Icon(Icons.photo_camera,
        //         size: 24, color: secondaryColor),
        //   ),
        // ),
        //   ]),
        // ),
        );
  }
}
