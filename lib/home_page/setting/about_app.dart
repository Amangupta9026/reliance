import '../../utils/file_collection.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
            children: [
              AppBarReusubility(title: 'About Us', isBackButton: true),
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10, 20, 40),
                  child: Column(
                    children: [
                      Text(
                          'Reliance Industries Limited is a Fortune 500 company and the largest private sector corporation in India.',
                          style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 25),
                      Text(
                          'Our motto “Growth is Life” aptly captures the ever-evolving spirit of Reliance. We have evolved from being a textiles and polyester company to an integrated player across energy, materials, retail, entertainment and digital services. In each of these areas, we are committed to innovation-led, exponential growth. Our vision has pushed us to achieve global leadership in many of our businesses.\n\n\nReliance products and services portfolio touches almost all Indians on a daily basis, across economic and social spectrums. We are now focussed on building platforms that will herald the Fourth Industrial Revolution and will create opportunities and avenues for India and all its citizens to realise their true potential.',
                          style: TextStyle(
                              fontSize: 16,
                              color: secondaryColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  )),
            ],
          )))),
    );
  }
}
