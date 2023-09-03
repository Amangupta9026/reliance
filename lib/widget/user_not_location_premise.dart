import '../utils/file_collection.dart';

class UserNotLocationPremise extends StatelessWidget {
  final String? commonApiResponseModel;
  const UserNotLocationPremise({super.key, this.commonApiResponseModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              location,
              width: 150,
            ),
            const SizedBox(height: 25),
            Center(
              child: Text(
                commonApiResponseModel ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ));
  }
}
