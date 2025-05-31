import 'package:cloud_firestore/cloud_firestore.dart';

class Databasehelper {
  Future addbookdetails(Map<String, dynamic> bookinfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('Books')
        .doc(id)
        .set(bookinfoMap);
  }

  Future<Stream<QuerySnapshot>> getAllBooksInfo() async {
    return await FirebaseFirestore.instance.collection("Books").snapshots();
  }

  Future updateBook(String id, Map<String, dynamic> updatedetails) async {
    return await FirebaseFirestore.instance
        .collection("Books")
        .doc(id)
        .update(updatedetails);
  }
  Future deletebook(String id) async{
      return await FirebaseFirestore.instance
        .collection("Books")
        .doc(id)
        .delete();
  }
}
