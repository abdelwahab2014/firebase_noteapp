import '../../model/import.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      success("Reset link sent");
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      error("Email not exist");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.6;
    double imageHeight = screenHeight * 0.3;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: Image.asset("images/forgot.png", fit: BoxFit.contain),
              ),
              // const Text("Please Enter your email to get password reset code"),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Input(
                  inputController: _emailController,
                  obscureText: false,
                  hintText: "Enter Email"),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              ElevatedButton(
                onPressed: () {
                  // try{}catch{Exception(e);}
                  {
                    if (_emailController.text.trim() != '') {
                      resetPassword();
                    } else {
                      error("Enter vaild email");
                    }
                  }
                },
                child: const Text("Send reset link"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}