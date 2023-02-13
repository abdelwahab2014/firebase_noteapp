import '../../model/import.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(MyController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      error(e.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageWidth = screenWidth * 0.8;
    double imageHeight = screenHeight * 0.4;
    double space = screenHeight * 0.02;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(
                  width: imageWidth,
                  height: imageHeight,
                  child: Image.asset("images/note.png", fit: BoxFit.contain),
                ),
                // Email
                Input(
                  hintText: "Enter Email",
                  inputController: _emailController,
                  obscureText: false,
                  //  inputFormatters: emailInputFormatter,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                // Password
                Input(
                  hintText: "Enter Password",
                  inputController: _passwordController,
                  obscureText: true,
                ),

                SizedBox(
                  height: screenHeight * 0.01,
                ),
                // reset Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgotPassword());
                      },
                      child: const Text(
                        "Forgotten Password",
                        style: MyStyles.textStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: space,
                ),
                // SignIn button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(screenWidth * 0.02),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      {
                        if (_emailController.text.trim() != '' &&
                            _passwordController.text.trim() != '' &&
                            _passwordController.text.trim().length >= 6) {
                          signIn();
                        } else {
                          error("Fill out fields");
                        }
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                ),
                SizedBox(
                  height: space * 0.2,
                ),

                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Row(
                    children: [
                      SizedBox(
                        height: space * 0.2,
                      ),
                      Text(
                        "Didn't have an account \t",
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.currenIndex.value = 1;
                          });
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.blue, fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
