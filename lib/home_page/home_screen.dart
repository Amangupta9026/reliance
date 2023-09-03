// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import '../riverpod/home_screen_notifier.dart';
import '../utils/file_collection.dart';

class HomePage extends ConsumerWidget {
  final UserDetail? userdata = UserData.geUserData();
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log(userdata?.authToken.toString() ?? '');
    log(userdata?.userid.toString() ?? '');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer(builder: (context, ref, child) {
                  final refWatch = ref.watch(homeScreenNotifierProvider);

                  return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.text,
                          controller: refWatch.value?.searchController,
                          onChanged: (value) async {
                            value = refWatch.value?.searchController.text ?? '';
                            value = value.toUpperCase();
                            log(value);
                            if (value.length == 10) {
                              context.pushNamed(
                                RouteNames.searchInventoryDetail,
                              );
                            }
                          },
                          style:
                              const TextStyle(fontSize: 18, color: textColor),
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: 'Search Code',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 2, color: secondaryColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: secondaryColor, width: 2.0)),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
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
                            ),
                          )));
                  // SearchWidgetTextField(
                  //     controller: refWatch.value?.searchController,
                  //     onChanged: (value) {
                  //       refWatch.value?.searchController.text = value;

                  //       log(value);
                  //     });
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
