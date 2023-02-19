import '../model/import.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    required this.inputController,
    required this.obscureText,
    required this.hintText,
    //required this.inputFormatters,
  });
  final TextEditingController inputController;
  final bool obscureText;
  final String hintText;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _showError = false;
  bool _showEye = false;
  bool securePassword = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double borderRadiusSize = screenWidth * 0.02;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(borderRadiusSize * 0.003),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadiusSize),
            ),
          ),
          padding: EdgeInsets.all(screenHeight * 0.002),
          child: TextField(
            controller: widget.inputController,
            obscureText: widget.obscureText ? securePassword : !securePassword,
            onChanged: (value) {
              // Show and hide eye
              if (value.isNotEmpty) {
                setState(() {
                  _showEye = true;
                });
              } else {
                setState(() {
                  _showEye = false;
                });
              }
              // show error for pw length
              if (value.length < 6 && value.isNotEmpty) {
                widget.obscureText
                    ? setState(() {
                        _showError = true;
                      })
                    : null;
              } else {
                setState(() {
                  _showError = false;
                });
              }
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
            ],
            decoration: InputDecoration(
              // Prefix icon
              prefixIcon: widget.hintText == "Enter Email"
                  ? const Icon(Icons.email_rounded)
                  : widget.hintText == "Enter Password" ||
                          widget.hintText == "Confirme Password"
                      ? const Icon(Icons.security_rounded)
                      : const Icon(
                          Icons.person_2_rounded,
                        ),
              // Hint Text
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              // Suffix Icon
              suffixIcon: widget.obscureText == true
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          securePassword = !securePassword;
                        });
                      },
                      child: Icon(securePassword
                          ? _showEye
                              ? Icons.remove_red_eye_rounded
                              : null
                          : _showEye
                              ? Icons.visibility_off_rounded
                              : null),
                    )
                  : null,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(
                  borderRadiusSize,
                ),
              ),
            ),
          ),
        ),
        // Show Error
        if (_showError)
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: const Text(
              "Password length less than 6",
              style: TextStyle(color: MyColors.whiteColor),
            ),
          )
      ],
    );
  }
}
