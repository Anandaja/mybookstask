import 'package:book_stask_/service/auth_service.dart';
import 'package:book_stask_/utils/toast.dart';
import 'package:flutter/material.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign up",
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("email"),
                hintText: "Enter your email",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("password"),
                hintText: "Enter your password ",
              ),
            ),

            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: () async {
                  await AuthService.createAccountwithemail(
                    emailcontroller.text,
                    passwordcontroller.text,
                  ).then((value) {
                    if (value == "Account create") {
                      message.show(message: "Account create");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/home",
                        (route) => false,
                      );
                    } else {
                      message.show(message: "error: $value");
                    }
                  });
                },
                child: Text("Sign up"),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Already have an account ?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
