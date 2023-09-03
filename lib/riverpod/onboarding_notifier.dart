// ignore_for_file: use_build_context_synchronously

import 'package:location/location.dart';

import '../utils/file_collection.dart';

final onBoardingNotifierProvider =
    AsyncNotifierProvider.autoDispose<SearchNotifier, OnBoardingMode>(() {
  return SearchNotifier();
});

class OnBoardingMode {
  int contentState = 0;
  bool enabled = false;

  bool isInternetCheck = false;
  final location = Location();

  // List of titles
  List<String> titles = [
    'Let us take care of you',
    'Always use a mask',
    'Always enable your location',
  ];

  // List of descriptions
  List<String> descriptions = [
    'We are here to teach you \nOur mentor are available and \nmonitor your skills 24 hrs/Day',
    'always use a mask when you want\nto travel and keep your\nbody immunity',
    'Always enable your location\nso that we can monitor\nyour location',
  ];

  // List of images path
  List<String> images = [
    'assets/images/onboarding1.png',
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png',
  ];
}

class SearchNotifier extends AutoDisposeAsyncNotifier<OnBoardingMode> {
  final OnBoardingMode _onBoardingMode = OnBoardingMode();

  // Get Title
  String getTitle(int contentState) {
    if (contentState == 0) {
      return _onBoardingMode.titles[0];
    } else if (contentState == 1) {
      return _onBoardingMode.titles[1];
    } else {
      return _onBoardingMode.titles[2];
    }
  }

  // Get Description
  String getDescription(int contentState) {
    if (contentState == 0) {
      return _onBoardingMode.descriptions[0];
    } else if (contentState == 1) {
      return _onBoardingMode.descriptions[1];
    } else {
      return _onBoardingMode.descriptions[2];
    }
  }

  // Get Images
  String getImage(int contentState) {
    if (contentState == 0) {
      return _onBoardingMode.images[0];
    } else if (contentState == 1) {
      return _onBoardingMode.images[1];
    } else {
      return _onBoardingMode.images[2];
    }
  }

  //next
  void next() {
    _onBoardingMode.contentState--;
    state = AsyncData(_onBoardingMode);
  }

  //pageChanged
  void pageChanged(BuildContext context) {
    if (_onBoardingMode.contentState == 2) {
      context.pushReplacementNamed(RouteNames.allPermissionList);
    }

    if (_onBoardingMode.contentState < 2) {
      _onBoardingMode.contentState++;
      state = AsyncData(_onBoardingMode);
    }
  }

  @override
  build() {
    return _onBoardingMode;
  }
}
