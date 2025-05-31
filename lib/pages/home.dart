import 'package:book_stask_/pages/books.dart';
import 'package:book_stask_/service/auth_service.dart';
import 'package:book_stask_/service/database.dart';
import 'package:book_stask_/utils/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController Pricecontroller = TextEditingController();
  TextEditingController Authorcontroller = TextEditingController();
  Stream? bookstream;
  dynamic getinfoinit() async {
    bookstream = await Databasehelper().getAllBooksInfo();
    setState(() {});
  }

  @override
  void initState() {
    getinfoinit();
    super.initState();
  }

  Widget AllBooksInfo() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot Snapshot) {
        return Snapshot.hasData
            ? ListView.builder(
              itemCount: Snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = Snapshot.data.docs[index];

                return Container(
                  margin: EdgeInsets.only(bottom: 21),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        // color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.book_rounded,
                                size: 40,
                                color: Colors.deepPurpleAccent,
                              ),
                              InkWell(
                                onTap: () {
                                  titlecontroller.text =
                                      documentSnapshot["Title"];
                                  Pricecontroller.text =
                                      documentSnapshot["Price"];
                                  Authorcontroller.text =
                                      documentSnapshot["Author"];
                                  editbook(documentSnapshot["id"]);
                                },
                                child: Icon(
                                  Icons.edit_document,
                                  size: 40,
                                  color: const Color.fromARGB(
                                    255,
                                    229,
                                    227,
                                    226,
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  showDeleteConfirmationDialog(
                                    context,
                                    documentSnapshot["id"],
                                  );
                                },
                                child: Icon(
                                  Icons.delete_forever,
                                  size: 45,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          Text(
                            "Title: ${documentSnapshot['Title']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Price:${documentSnapshot['Price']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Author:${documentSnapshot['Author']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            : Container();
      },
      stream: bookstream,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Stash'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.Logout();
              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 25),
        child: Column(children: [Expanded(child: AllBooksInfo())]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Books()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future editbook(String id) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit a book ',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          size: 35,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 10, color: Colors.deepPurple, thickness: 5),
                  SizedBox(height: 10),
                  Text(
                    'Title ',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: titlecontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Text(
                    'Price',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: Pricecontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Text(
                    'Author ',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: Authorcontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          Map<String, dynamic> updatedetails = {
                            "Title": titlecontroller.text,
                            "Price": Pricecontroller.text,
                            "Author": Authorcontroller.text,
                            "id": id,
                          };
                          await Databasehelper()
                              .updateBook(id, updatedetails)
                              .then((value) {
                                message.show(message: "successfully updated");
                                Navigator.pop(context);
                              });
                        },
                        child: Text("Update"),
                      ),

                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this book?'),
          actions: [
            TextButton(
              onPressed: () async {
                await Databasehelper().deletebook(id);
                Navigator.pop(context); // close the dialog
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // close the dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}
