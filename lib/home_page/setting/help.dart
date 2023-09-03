import '../../../utils/file_collection.dart';

class HelpSupport extends ConsumerWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final refRead = ref.read(feedbackNotifierProvider.notifier);
    // final refWatch = ref.watch(feedbackNotifierProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const AppBarReusubility(
                  title: 'Help & Support', isBackButton: true),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 60),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Subject',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const TextFormFieldWidget(
                          //  controller1: refWatch.value?.subjectController,
                          hintText: 'Please type subject'),
                      const SizedBox(height: 30),
                      const Text('Message',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      const SizedBox(height: 15),
                      const TextFormFieldWidget(
                        //  controller1: refWatch.value?.messageController,
                        hintText: 'Please type your message',
                        maxLines: 5,
                      ),
                      const SizedBox(height: 40),
                      buttonSizedBox(
                        primaryColor,
                        'Submit',
                        () {
                          // refRead.submitFeedback();
                        },
                      )
                    ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
