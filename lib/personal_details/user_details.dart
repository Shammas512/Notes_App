import 'dart:convert';  // Import for JSON encoding
import 'dart:io';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/personal_details/container_user.dart';
import 'package:image_picker/image_picker.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();

  void postingApi(String namee, String agee, String emaile) async {
    try {
      Response response = await post(
        Uri.parse(
          'https://crudcrud.com/api/acaf3a12056c4c5cb7ab403172ae48b6/unicorns',
        ),
        headers: {
          "Content-Type": "application/json",  // Specify content type
        },
        body: jsonEncode({
          "name": namee,
          "age": agee,
          "email": emaile,
        }),
      );


      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Details Added On Server"),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 700),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed"),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 700),
        ));
      }
    } catch (e) {
      print("Error: $e");  // More detailed error logging
    }

    // setState(() {
    //   name.clear();
    //   age.clear();
    //   email.clear();
    // });
  }

  String? selectedLocation;
  File? image;

  Future<void> getimage() async {
    final pickedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage == null) {
      return;
    }
    setState(() {
      image = File(pickedimage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image != null
                ? Center(
                    child: CircleAvatar(
                        radius: 70, backgroundImage: FileImage(image!)))
                : InkWell(
                    onTap: getimage,
                    child: const Center(
                        child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://thumbs.dreamstime.com/b/person-icon-flat-vector-illustration-design-isolated-white-background-156044979.jpg'),
                    ))),
            const SizedBox(height: 20),
            ContainerUser(
              text: 'Enter Your Name',
              controller: name,
            ),
            const SizedBox(height: 20),
            ContainerUser(
              text: 'Enter Your Age',
              controller: age,
            ),
            const SizedBox(height: 20),
            ContainerUser(
              text: 'Enter Your Email',
              controller: email,
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                postingApi(name.text, age.text, email.text);
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.greenAccent[700],
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text("Register"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
