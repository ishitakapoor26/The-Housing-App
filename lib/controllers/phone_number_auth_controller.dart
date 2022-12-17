import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class PhoneNumberController extends GetxController {
  RxBool sentOTP = false.obs;
  RxBool userVerified = false.obs;
  var user = auth.currentUser.obs;
  String verificationId = "";
  final _storage = const FlutterSecureStorage();
  verifyPhoneNumber(String phoneNumber) async {
    print(phoneNumber);
    await auth.verifyPhoneNumber(
      phoneNumber: '+91' + phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // var result = await auth.signInWithCredential(credential);
        // var currentUser = result.user;

        // if (user != null) {}
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // show_message("Invalid Number", "error", "Please give a valid number");
          print("Invalid Number");
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // show_message("OTP Sent", "success", "");
        print("OTP SENT");
        sentOTP.value = true;
        this.verificationId = verificationId;
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  Future<void> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      var currentUser = await auth.signInWithCredential(credential);
      // print(currentUser.toString());
      _storage.write(key: "user", value: currentUser.user.toString());
      _storage.write(key: "phone", value: currentUser.user!.phoneNumber);

      userVerified.value = true;
      user.value = currentUser.user;
      print("OTP VERIFIED");
    } catch (e) {
      // show_message(e.toString(), "error", "");
      print("Some error occured");
      throw e;
    }
  }
}
