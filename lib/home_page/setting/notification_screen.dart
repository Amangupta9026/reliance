import '../../riverpod/notification_notifier.dart';
import '../../utils/file_collection.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer(builder: (context, ref, child) {
          return FutureBuilder(
              future: ref
                  .read(notifierProvider.notifier)
                  .apiNotifyListnerList(context),
              builder: (context, snapshot) {
                final refData = snapshot.data;
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const AppBarReusubility(
                            title: 'Notifications', isBackButton: true),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 60),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, int index) {
                                return Column(
                                  children: [
                                    if (!snapshot.hasData &&
                                        refData?.status == 'false')
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 90),
                                          Image.asset(
                                            notification,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                          ),
                                          const SizedBox(height: 20),
                                          const Text('No New Notifications',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                          const SizedBox(height: 5),
                                          const Text(
                                              'There are no notifications at the moment',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    if (snapshot.hasData &&
                                        refData?.status == 'true')
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: backgroundColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15.0, 15, 15, 17),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(height: 5),
                                                      Text(
                                                          refData?.message ??
                                                              '',
    
                                                          // 'Inventory System Records Updated',
                                                          style: const TextStyle(
                                                              color: textColor,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      const SizedBox(height: 8),
                                                      const Text(
                                                          'Inventory Management System has been updated by the admin. Please check the updated records. Thank you.',
                                                          style: TextStyle(
                                                              color: textColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Text(
                                                          '21/07/2023 05:00 PM',
                                                          style: TextStyle(
                                                              color: textColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
