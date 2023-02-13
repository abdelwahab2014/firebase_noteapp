import '../../model/import.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = Get.put(MyController());
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmeController = TextEditingController();

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
    _nameController.dispose();
    _passwordConfirmeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageWidth = screenWidth * 0.6;
    double imageHeight = screenHeight * 0.3;
    //double fontSize = screenWidth * 0.02;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              children: [
                // image
                SizedBox(
                  width: imageWidth,
                  height: imageHeight,
                  child: Image.asset("images/signup.png", fit: BoxFit.contain),
                ),
                // userName
                Input(
                  hintText: "Enter your name ",
                  inputController: _nameController,
                  obscureText: false,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
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
                Input(
                  hintText: "Enter Password",
                  inputController: _passwordController,
                  obscureText: true,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Input(
                  hintText: "Confirme Password",
                  inputController: _passwordConfirmeController,
                  obscureText: true,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    {
                      if (_emailController.text.trim() != '' &&
                          _passwordController.text.trim() != '') {
                        if (_passwordController.text.trim() ==
                            _passwordConfirmeController.text.trim()) {
                          signUp();
                        } else {
                          error("Password mismatch");
                        }
                      } else {
                        error("Fill out fields");
                      }
                    }
                  },
                  child: const Text("Sign Up"),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  children: [
                    Text(
                      "Already have an account \t",
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.currenIndex.value = 0;
                        });
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
