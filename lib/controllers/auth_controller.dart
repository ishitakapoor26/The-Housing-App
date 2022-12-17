import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:housingapp/view/widgets/snackBar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:housingapp/models/builder_model.dart' as model;
import 'package:housingapp/models/agent_Model.dart' as mod;
import '../constant.dart';
import '../models/builder_Model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  // late Rx<User?> _user;
  Rx<File?>? pickedImage;
  File? get profilePhoto => pickedImage!.value;
  String imageURL = "";

  @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(firebaseAuth.currentUser);
  //   _user.bindStream(firebaseAuth.authStateChanges());
  //   //ever(_user, _setInitialScreen);
  // }

  // _setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => LoginScreen());
  //   } else {
  //     Get.offAll(
  //         () => IamBuilder()); //id: FirebaseAuth.instance.currentUser!.uid
  //   }
  // }

  Future pickImage() async {
    final ppickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (ppickedImage != null) {
      // Get.snackbar('Profile Picture', 'Successfully selected');
      // showSnackBar(context, "Profile Phot")
      pickedImage = Rx<File?>(File(ppickedImage.path));
      // imageURL = await _uploadAgentToStorage(pickedImage!.value!);
    }
  }

  //upload builder profile to storage
  Future<String> _uploadAgentToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('AgentprofilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Upload Agent Profile to storage
  Future<String> _uploadBuilderToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('BuilderprofilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //register builder
  void register_builder(
      String username,
      String email,
      String phNo,
      String password,
      String reraNo,
      File? image,
      String companyName,
      String companyRegistrationNo,
      String companyAdd,
      String gstInvoice,
      String city,
      List<String> adhaar,
      List<String> reraPhoto,
      bool isAgent,
      bool isBuilder,
      bool isVerified,
      context) async {
    try {
      if (username.isNotEmpty &&
          password.isNotEmpty &&
          email.isNotEmpty &&
          image != null) {
        // save user
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadBuilderToStorage(image);
        BuilderModel builder = BuilderModel(
            isAgent: isAgent,
            isBuilder: isBuilder,
            city: city,
            company_add: companyAdd,
            company_name: companyName,
            company_registration_no: companyRegistrationNo,
            gst_invoice: gstInvoice,
            ph_no: phNo,
            rera_no: reraNo,
            email: email,
            name: username,
            adhaar_photo: adhaar,
            rera_photo: reraPhoto,
            profilePhoto: downloadUrl,
            uid: cred.user!.uid,
            isVerified: isVerified);
        await firestore
            .collection('builder')
            .doc(cred.user!.uid)
            .set(builder.toJson());
      } else {
        // Get.snackbar('Error creating account', 'please enter all the fields');
        showSnackBar(
            context, "Error creating account : please enter all the fields");
      }
    } catch (e) {
      // Get.snackbar('Error creating account', e.toString());
      print("Error creating account + ${e.toString()}");
      // showSnackBar(context, "Error creating account + ${e.toString()}");
    }
  }

  //register agent
  Future<String>? register_agent(
      String username,
      String email,
      String phNo,
      String password,
      // String reraNo,
      String city,
      File? image,
      bool isAgent,
      bool isBuilder,
      bool isVerified,
      context) async {
    try {
      if (username.isNotEmpty &&
          password.isNotEmpty &&
          email.isNotEmpty &&
          image != null) {
        // save user
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadAgentToStorage(image);
        // String downloadUrl = imageURL;
        mod.Agent agent = mod.Agent(
            isAgent: isAgent,
            isBuilder: isBuilder,
            city: city,
            ph_no: phNo,
            // rera_no: reraNo,
            email: email,
            name: username,
            profilePhoto: downloadUrl,
            uid: cred.user!.uid,
            isVerified: isVerified);
        await firestore
            .collection('agent')
            .doc(cred.user!.uid)
            .set(agent.toJson());
        return cred.user!.uid;
      } else {
        // Get.snackbar('Error creating account', 'please enter all the fields');
        showSnackBar(
            context, "Error creating account : please enter all the fields");
        return "Error";
      }
    } catch (e) {
      // Get.snackbar('Error creating account', e.toString());
      showSnackBar(context, "Error creating account + ${e.toString()}");
      return "Error in creating account";
    }
  }

  register_agent_advanced(
      String docid,
      String rera_no,
      String rera_image,
      String yoe,
      String typeOfAgent,
      String companyName,
      String companyAdd,
      String companyWeb,
      String companyPAN,
      String? focusArea,
      List<String>? associations,
      context) async {
    try {
      if (true) {
        // save user
        // String downloadUrl = await _uploadAgentToStorage(image);
        // String downloadUrl = imageURL;
        // mod.Agent agent = mod.Agent(
        //     isAgent: isAgent,
        //     isBuilder: isBuilder,
        //     city: city,
        //     ph_no: phNo,
        //     // rera_no: reraNo,
        //     email: email,
        //     name: username,
        //     profilePhoto: downloadUrl,
        //     uid: cred.user!.uid,
        //     isVerified: isVerified);
        var agent = {
          "rera_image": rera_image,
          "rera_no": rera_no,
          "yoe": yoe,
          "typeOfAgent": typeOfAgent,
          "companyName": companyName,
          "companyAdd": companyAdd,
          "companyWeb": companyWeb,
          // "companyRera": companyRera,
          "pan_image": companyPAN,
          "focus_area": focusArea,
          "associations": associations,
        };
        await firestore.collection('agent').doc(docid).update(agent);
        return "Successfull";
      } else {
        // Get.snackbar('Error creating account', 'please enter all the fields');
        // showSnackBar(
        //     context, "Error creating account : please enter all the fields");
        return "Error";
      }
    } catch (e) {
      // Get.snackbar('Error creating account', e.toString());
      // showSnackBar(context, "Error creating account + ${e.toString()}");
      return "Error in creating account";
    }
  }

  void loginUser(String email, String password, context) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        showSnackBar(
          context,
          'Error Logging in : Please enter all the fields',
        );

        // Get.snackbar(
        // 'Error Logging in : Please enter all the fields',
        // );
      }
    } catch (e) {
      // Get.snackbar(
      //   'Error Logging in',
      //   e.toString(),
      // );
      showSnackBar(
        context,
        'Error Logging in : ${e.toString()}',
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}


// else {
//         // Get.snackbar('Error creating account', 'please enter all the fields');
              // showSnackBar(context, "Error creating account : please enter all the fields");
//       }
//     } catch (e) {
//       // Get.snackbar('Error creating account', e.toString());
//       showSnackBar(context, "Error creating account + ${e.toString()}");
//     }