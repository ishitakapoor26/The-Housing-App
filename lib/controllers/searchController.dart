// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../constant.dart';
// import '../../../models/builder_model.dart';
//
//
// class SearchController extends GetxController {
//   final Rx<List<Builder>> _searchedUsers = Rx<List<Builder>>([]);
//
//   List<Builder> get searchedUsers => _searchedUsers.value;
//
//   searchUser(String typedUser) async {
//     _searchedUsers.bindStream(firestore
//         .collection('builder')
//         .where('name', isGreaterThanOrEqualTo: typedUser)
//         .snapshots()
//         .map((QuerySnapshot query) {
//       List<Builder> retVal = [];
//       for (var elem in query.docs) {
//         retVal.add(Builder.fromSnap(elem));
//       }
//       return retVal;
//     }));
//   }
// }