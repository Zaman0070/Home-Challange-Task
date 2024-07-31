import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'ERROR HERE',
          style: getBoldStyle(fontSize: 17 ,color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
