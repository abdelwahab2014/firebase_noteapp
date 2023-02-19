
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

  Future addUser(String collectionName) async {
    await FirebaseFirestore.instance.collection("UserName").add({
      // key: value here!!
      'userName': _nameController.text.trim(),
    });
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      addUser(_emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      error(e.message.toString());
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
    //final currentUser = FirebaseAuth.instance.currentUser!;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            decoration: BoxDecoration(gradient: bgContainer),
            padding: EdgeInsets.all(screenWidth * 0.05),
            //padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight / 4,
                ),

                // userName
                Input(
                  hintText: "Full name ",
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
                          // addUserName(_emailController.text.trim());
                        } else {
                          error("Password don't match");
                        }
                      } else {
                        error("Fill out all fields");
                      }
                    }
                  },
                  child: const Text("Sign Up"),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Row(
                  children: [
                    Text(
                      "Already have an account? \t",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: MyColors.whiteColor),
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
                          color: Colors.white,
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
