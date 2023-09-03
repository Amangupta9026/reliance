import '../utils/file_collection.dart';

class UserLocationNotPremises extends StatelessWidget {
  final CommonApiResponseModel? response;
  const UserLocationNotPremises({super.key, this.response});

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppBarReusubility(
                    title: "Location is not RIL Premises", isBackButton: true),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        location,
                        height: MediaQuery.of(context).size.height * 0.20,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        response?.message ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
