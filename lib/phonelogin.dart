import 'package:flutter/material.dart';
import 'package:newapp/phoneverification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  static String verify ="";
  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController(); // Add this controller

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();

    // Initialize Firebase App Check with your App Check site key.
   // FirebaseAppCheck.instance.activate();
  }

  Future<Widget> loadAndDisplayImage() async {
    String imagePath = 'img1.png'; // Replace with the actual path to your image in Firebase Storage

    // Create a reference to the Firebase Storage location of the image.
    Reference storageRef = FirebaseStorage.instance.ref().child(imagePath);

    // Get the download URL of the image.
    String downloadURL = await storageRef.getDownloadURL();

    // Use the download URL to load and display the image using the Image.network widget.
    return Image.network(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Widget>(
                future: loadAndDisplayImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data ?? Text("Image not found");
                  } else if (snapshot.hasError) {
                    return Text("Error loading image");
                  } else {
                    return CircularProgressIndicator(); // Show a loading indicator while the image is being fetched.
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneController, // Use the phoneController
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    String countryCode = countryController.text;
                    String phoneNumber = phoneController.text;
                    String completePhoneNumber = '$countryCode$phoneNumber';

                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: completePhoneNumber,
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        PhoneLogin.verify = verificationId;
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Phoneverification(),
                      ),
                    );
                  },
                  child: const Text("Send the code"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
