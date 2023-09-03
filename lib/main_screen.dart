
import '../utils/file_collection.dart';
import 'riverpod/page_index_selector.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget page(index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return const WorkFlow();
      case 2:
        return const Setting();
      case 3:
        return const ProfileScreen();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final refRead = ref.read(pageIndexNotifierProvider.notifier);
      final refWatch = ref.watch(pageIndexNotifierProvider);
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          bottomNavigationBar: BottomBarDoubleBullet(
            selectedIndex: refWatch.value!.indexValue,
            color: primaryColor,
            backgroundColor: backgroundColor,
            items: [
              BottomBarItem(iconData: Icons.home),
              BottomBarItem(
                iconData: Icons.shelves,
              ),
              BottomBarItem(
                iconData: Icons.settings,
              ),
              BottomBarItem(iconData: Icons.person),
            ],
            onSelect: (index) {
              refRead.changeIndex(index);
            },
          ),
          body: page(refWatch.value!.indexValue),
        ),
      );
    });
  }
}
