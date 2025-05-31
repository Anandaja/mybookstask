import 'package:book_stask_/service/database.dart';
import 'package:book_stask_/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController Pricecontroller = TextEditingController();
  TextEditingController Authorcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a Book')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Center(
                child: OutlinedButton(
                  onPressed: () async {
                    String id = randomAlphaNumeric(10);

                    Map<String, dynamic> bookinfoMap = {
                      "Title": titlecontroller.text,
                      "Price": Pricecontroller.text,
                      "Author": Authorcontroller.text,
                      "id":id
                    };
                    await Databasehelper().addbookdetails(bookinfoMap, id).then(
                      (value) {
                        message.show(message: 'Book has been added');
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
