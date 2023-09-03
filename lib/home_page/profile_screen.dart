// ignore_for_file: use_build_context_synchronously

import '../utils/file_collection.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titlevalue = const TextStyle(
        color: textColor, fontSize: 16, fontWeight: FontWeight.w500);
    TextStyle title = const TextStyle(
        color: textColor, fontSize: 18, fontWeight: FontWeight.w700);
    final userdata = UserData.geUserData();
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBarReusubility(
                  title:
                      '${userdata?.firstname ?? ''} ${userdata?.lastname ?? ''}',
                  isBackButton: false),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email ID", style: title),
                    const SizedBox(height: 10),
                    Text(userdata?.email ?? '', style: titlevalue),
                    const SizedBox(height: 25),
                    Text("Mobile Number", style: title),
                    const SizedBox(height: 10),
                    Text(userdata?.mobileno ?? '', style: titlevalue),
                    const SizedBox(height: 25),
                    Text("Plant Name", style: title),
                    const SizedBox(height: 10),
                    Text(userdata?.plantname ?? '', style: titlevalue),
                    const SizedBox(height: 25),
                    if (userdata?.useraccess == "UNIT") ...{
                      Text("Unit Name", style: title),
                      const SizedBox(height: 10),
                      Text(userdata?.unitname ?? '', style: titlevalue),
                    } else ...{
                      Text('Workshop Name', style: title),
                      const SizedBox(height: 10),
                      Text(userdata?.workshopname ?? '', style: titlevalue),
                    },
                    const SizedBox(height: 25),
                    Text("Department Name", style: title),
                    const SizedBox(height: 10),
                    Text(userdata?.department ?? '', style: titlevalue),
                    const SizedBox(height: 25),
                    Text("Employee ID", style: title),
                    const SizedBox(height: 10),
                    Text(userdata?.employeeid ?? '', style: titlevalue),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
