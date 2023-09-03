// ignore_for_file: use_build_context_synchronously

import '../../utils/file_collection.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                const AppBarReusubility(title: 'Setting', isBackButton: false),
                Category(
                    txt: "Notification",
                    padding: 35.0,
                    icon: Icons.notifications,
                    tap: () {
                      context.pushNamed(RouteNames.notification);
                    }),
                _line(),
                Category(
                    txt: "Help & Support",
                    padding: 30.0,
                    icon: MdiIcons.faceAgent,
                    tap: () {
                      context.pushNamed(RouteNames.helpSupport);
                    }),
                _line(),
                Category(
                    padding: 38.0,
                    txt: "About Apps",
                    icon: MdiIcons.handHeart,
                    tap: () {
                      context.pushNamed(RouteNames.aboutApp);
                    }),
                _line(),
                Category(
                  padding: 38.0,
                  txt: "Logout",
                  icon: Icons.logout,
                  tap: () {
                    showMyDialog(
                        context,
                        'Logout',
                        'Are you sure you want to logout?',
                        () async {
                          EasyLoading.show(status: 'Loading...');
                          await ApiService().logoutUser();
                          Prefs.clear();
                          EasyLoading.dismiss();
                          toast('Logged Out Successfully');
                          context.pushNamed(RouteNames.onBoarding);
                        },
                        istwobutton: true,
                        actionButtonText1: 'No',
                        actionButtonText2: 'Yes',
                        actiontap1: () {
                          context.pop();
                        });
                  },
                ),
                _line(),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),
              ]),
            ),
          )),
    );
  }

  Widget _line() {
    return const Padding(
      padding: EdgeInsets.only(left: 30, right: 30.0),
      child: Divider(
        color: Colors.black26,
        height: 2.0,
      ),
    );
  }
}

/// Component category class to set list
class Category extends StatelessWidget {
  final String? txt;
  final IconData? icon;
  final GestureTapCallback? tap;
  final double? padding;

  const Category({super.key, this.txt, this.icon, this.tap, this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 30.0, bottom: 25),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding ?? 0.0),
                  child: Icon(
                    icon,
                    size: 28.0,
                    color: secondaryColor,
                  ),
                ),
                Text(txt ?? '',
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: textColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
