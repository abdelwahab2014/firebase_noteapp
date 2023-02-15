import './model/import.dart';
import 'auth/auth.dart';
import 'note.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
          // check if your user  auth State Changes or not 
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const 
             Note();
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
