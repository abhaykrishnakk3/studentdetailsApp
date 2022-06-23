import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db/db_functions.dart';
import 'package:student_management/model/data_model.dart';

class ScreenAdd extends StatefulWidget {
  ScreenAdd({Key? key}) : super(key: key);

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _placeController = TextEditingController();

  // int? idnum;

  File? imagefile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 80, top: 20),
                      child: Text(
                        'Add Student',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(child: imageprofile(context)),
                    const SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _nameController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Student Name',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _ageController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Age', border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                          hintText: 'Enter the Number',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _placeController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Place',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(color: Colors.red)))),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          onAddStudentButtonClicked();
                          // Navigator.of(context).pop();
                        },
                        child: const Text('Add Student'))
                  ],
                ))
          ]),
        ),
      ),
    );
  }

  Future<void> takePhoto() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File imageTemprary = File(image.path);
    setState(() {
      imagefile = imageTemprary;
    });
    imageadd(image);
  }

  Future<void> takecamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    final imageTemprary = File(image.path);
    setState(() {
      imagefile = imageTemprary;
    });
    imageadd(image);
  }

  Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx1) {
        return Container(
          height: 100,
          width: double.infinity,
          color: Colors.blue,
          child: Column(children: [
            const Text('choise your profile photo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      takecamera();
                    },
                    icon: const Icon(Icons.camera)),
                IconButton(
                    onPressed: () {
                      takePhoto();
                    },
                    icon: const Icon(Icons.browse_gallery))
              ],
            )
          ]),
        );
      },
    );
  }

  Widget imageprofile(BuildContext context) {
    return Stack(
      children: [
        imagefile != null
            ? Image.file(
                imagefile!,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/profile-anonymous-face-icon-gray-260nw-789318310.webp',
                width: 250,
                height: 250),
        Padding(
          padding: const EdgeInsets.only(top: 150, left: 150),
          child: IconButton(
              onPressed: () {
                showBottomSheet(context);
              },
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.green,
                size: 80,
              )),

              
        )
      ],
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = _nameController.text;
    final age = _ageController.text;
    final phoneNumber = _phoneNumberController.text;
    final place = _placeController.text;
    if (name.isEmpty || age.isEmpty || phoneNumber.isEmpty || place.isEmpty) {
      return;
    } else {
      final _student = StudentModel(
        name: name,
        age: age,
        phoneNumber: phoneNumber,
        place: place,
        imgstri: imgstring,
      );

      addStudent(_student);
      imgstring = '';
    }
  }
}
