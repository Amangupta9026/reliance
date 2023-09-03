import '../utils/file_collection.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppUtils.checkInternet(context);
    return Consumer(builder: (context, ref, child) {
      final refWatch = ref.watch(onBoardingNotifierProvider);
      final refRead = ref.read(onBoardingNotifierProvider.notifier);
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            backgroundColor: primaryColor,
            body: SafeArea(
              child: Stack(children: [
                // Image Illustration
                // Container(
                //   margin: const EdgeInsets.only(top: 0.0),
                //   child: Image(
                //     height: 640.0,
                //     image: AssetImage(getImage(contentState)),
                //   ),
                // ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Image(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.7,
                      image: const AssetImage(dssiqLogo),
                    ),
                  ),
                ),

                // Top Components
                Container(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          refWatch.value?.contentState != 0
                              ? GestureDetector(
                                  onTap: () {
                                    refRead.next();
                                  },
                                  child: const Icon(Icons.arrow_back_ios,
                                      color: secondaryColor, size: 18.0))
                              : const SizedBox(),
                          refWatch.value?.contentState != 2
                              ? InkWell(
                                  onTap: () {
                                    context.pushReplacement(
                                        RouteNames.allPermissionList);
                                  },
                                  child: const Text('Skip',
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.w600)))
                              : const SizedBox(),
                        ])),
                // Content
                Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Title
                                  Text(
                                      refRead.getTitle(
                                          refWatch.value?.contentState ?? 0),
                                      style: const TextStyle(
                                          color: secondaryColor,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 16.0),
                                  // Description
                                  Text(
                                      refRead.getDescription(
                                          refWatch.value?.contentState ?? 0),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: secondaryColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w300)),
                                  const SizedBox(height: 40.0),
                                  // Bottom Components
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Indicator
                                        Row(children: [
                                          for (int i = 0; i < 3; i++) ...{
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                child: Container(
                                                  height: 4.0,
                                                  width: refWatch.value
                                                              ?.contentState ==
                                                          i
                                                      ? 18.0
                                                      : 12.0,
                                                  color: refWatch.value
                                                              ?.contentState ==
                                                          i
                                                      ? primaryColor
                                                      : const Color(0xFFCBD6F3),
                                                )),
                                            const SizedBox(width: 4.0)
                                          }
                                        ]),
                                        // Button Next
                                        GestureDetector(
                                            onTap: () {
                                              refRead.pageChanged(context);
                                            },
                                            child: const Icon(
                                              Icons.arrow_forward,
                                              color: primaryColor,
                                            )),
                                      ]),
                                ]))))
              ]),
            )),
      );
    });
  }
}
