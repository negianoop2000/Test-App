import 'package:flutter/material.dart';
import 'package:newapp/product_list.dart';

import 'Firebase Services/google_signin.dart';

class Login_Signup extends StatefulWidget {
  const Login_Signup({super.key});

  @override
  State<Login_Signup> createState() => _Login_SignupState();
}

class _Login_SignupState extends State<Login_Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 91, 143),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.48,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.black;
                    }
                    return Colors.white;
                  })),
                  onPressed: () async {
                    await FirebaseServices().signInWithGoogle();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Product_List()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 25)),
                      Image.network(
                        "https://assets.stickpng.com/images/5847f9cbcef1014c0b5e48c8.png",
                        height: 35,
                        width: 35,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
