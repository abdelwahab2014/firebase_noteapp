
import '../../model/import.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // controller
  final controller = Get.put(MyController());

  // pages
  List pages = [const LoginPage(), const SignUpPage()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.amber,
        body:  Obx(
            () => pages[controller.currenIndex.value],
          ),
        
      ),
    );
  }
}
