import 'dart:io';


import 'package:flutter/material.dart';
import 'package:notesapp/personal_details/container_user.dart';
import 'package:image_picker/image_picker.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String? selectedLocation;
  File? image;
  Future<void> getimage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
                    )),
                  ),
            const SizedBox(
              height: 20,
            ),
            ContainerUser(
              text: 'Enter Your Name',
            ),

            const SizedBox(
              height: 20,
            ),

            ContainerUser(text: 'Enter Your Username'),

            const SizedBox(
              height: 20,
            ),

            ContainerUser(
              text: 'Enter Your Email',
            ),

            const SizedBox(
              height: 20,
            ),

            // ContainerUser(text: 'Select Your Location',),
            Container(
              height: 70,
              width: 230,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                value: selectedLocation,
                hint: const Text('Select Location'),
                isExpanded: true,
                underline: const SizedBox(),
                items: ['New York', 'Berlin', 'Tokyo', 'London','Pakistan']
                    .map((location) => DropdownMenuItem<String>(
                          value: location,
                          child: Text(location),
                        ))
                    .toList(),
                onChanged: (nwValue) {
                  setState(() {});
                  selectedLocation = nwValue!;
                },
              ),
            ),

            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "Your Informations Is Recorded",
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ));
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.greenAccent[700],
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text("Regeiter"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
