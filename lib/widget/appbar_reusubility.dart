import '../utils/file_collection.dart';

class AppBarReusubility extends StatelessWidget {
  final String? title;
  final bool? isBackButton;
  const AppBarReusubility({super.key, this.title, this.isBackButton});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ClipPath(
          clipper: BottomWaveClipper(),
          child: Container(
            height: 160.0,
            width: double.infinity,
            decoration: const BoxDecoration(color: primaryColor),
          )),
      const TriangleDesign(top: 20.0, left: 10.0),
      const TriangleDesign(top: 110.0, left: 80.0),
      const TriangleDesign(top: 60.0, left: 190.0),
      const TriangleDesign(top: 40.0, left: 300.0),
      const TriangleDesign(top: 130.0, left: 330.0),
      Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isBackButton ?? false
                  ? const SizedBox(height: 0)
                  : const SizedBox(height: 25),
              Visibility(
                  visible: isBackButton ?? true,
                  child: const Column(
                    children: [
                      CustomBackButton(),
                    ],
                  )),
              const SizedBox(height: 20),
              Text(
                title ?? '',
                style: const TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              )
            ]),
      )
    ]);
  }
}
