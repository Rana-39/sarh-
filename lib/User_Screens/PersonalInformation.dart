import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'User_Settings.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}


class _PersonalInformationState extends State<PersonalInformation> {
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  XFile? _imageFile; // Store the selected image file
  String? _imageUrl; // Store the downloaded image URL (initially null)

  // Get a reference to Firebase Storage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _selectImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return; // Handle no image selected

    // Create a reference to the user's profile image in storage
    final user = FirebaseAuth.instance.currentUser!;
    final imageRef = _storage.ref().child('profile_images/${user.uid}.jpg');

    try {
      final uploadTask = await imageRef.putFile(File(_imageFile!.path));
      final url = await uploadTask.ref.getDownloadURL();
      setState(() {
        _imageUrl = url; // Update the image URL
      });
    } on FirebaseException catch (e) {
      // Handle upload error
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _downloadImage() async {
    if (_imageUrl == null) return; // Handle no image URL

    try {
      // Consider using a secure cache mechanism if necessary
      final imageUrl = await _storage.ref().child(_imageUrl!).getDownloadURL();
      setState(() {
        _imageUrl = imageUrl; // Update in case the URL has changed
      });
    } on FirebaseException catch (e) {
      // Handle download error
      print('Error downloading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading image: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Expanded(
              child: Column(children: [
                Row(children: [
                  Transform(
                    transform: Matrix4.translationValues(-10, 0.0, 0.0),
                    child: const Icon(Icons.chat_bubble_outline_rounded),
                  ),
                  GestureDetector(
                      child: const Text(
                        "     البيانات الشخصية ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const User_Settings()),
                        );
                      }),
                  Transform(
                    transform: Matrix4.translationValues(-250, 0.0, 0.0),
                    child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                      size: 19,
                    ),
                  ),
                ]),
                const Divider(
                  color: Color.fromARGB(255, 239, 167, 167),
                  thickness: 5,
                  indent: 7,
                  endIndent: 150,
                ),
                Stack(
                  children: [
                    _imageUrl != null
                        ? CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(_imageUrl!),
                    )
                        : const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIwRBD9gNuA2GjcOf6mpL-WuBhJADTWC3QVQ&usqp=CAU'),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () => _selectImage().then(_uploadImage as FutureOr Function(void value)),
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error = ${snapshot.error}');
                    }
                    Map<String, dynamic> data = snapshot.data!.data()!;
                    TextEditingController controller = TextEditingController(
                        text: data[
                            'first name']); // Create a TextEditingController
                    return Transform(
                      transform: Matrix4.translationValues(-10, 0.0, 0.0),
                      child: Row(
                        children: [
                          const Text(
                            'الاسم الاول: ',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 220,
                            height: 50,
                            child: TextField(
                              controller:
                                  controller, // Set the controller for the TextField
                              decoration: InputDecoration(
                                labelText:
                                    'الاسم الاول', // Label for the TextField
                                border:
                                    const OutlineInputBorder(), // Border for the TextField
                                fillColor: Colors.grey.shade400,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16.0),
                                alignLabelWithHint: true,
                              ),
                              style: const TextStyle(
                                  fontSize:
                                      16), // Style for the text in the TextField
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                // Update the data when the TextField value changes
                                data['first name'] = value;

                                // Update Firestore with the new data
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({'first name': value})
                                    .then((_) =>
                                        print('Name updated successfully'))
                                    .catchError((error) =>
                                        print('Failed to update name: $error'));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error = ${snapshot.error}');
                    }
                    Map<String, dynamic> data = snapshot.data!.data()!;
                    TextEditingController controller = TextEditingController(
                        text: data[
                            'last name']); // Create a TextEditingController
                    return Transform(
                      transform: Matrix4.translationValues(-10, 0.0, 0.0),
                      child: Row(
                        children: [
                          const Text(
                            'الاسم الاخير: ',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 220,
                            height: 50,
                            child: TextField(
                              controller:
                                  controller, // Set the controller for the TextField
                              decoration: InputDecoration(
                                labelText:
                                    'الاسم الاخير', // Label for the TextField
                                border:
                                    const OutlineInputBorder(), // Border for the TextField
                                fillColor: Colors.grey.shade400,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16.0),
                                alignLabelWithHint: true,
                              ),
                              style: const TextStyle(
                                  fontSize:
                                      16), // Style for the text in the TextField
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                // Update the data when the TextField value changes
                                data['last name'] = value;

                                // Update Firestore with the new data
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({'last name': value})
                                    .then((_) =>
                                        print('Name updated successfully'))
                                    .catchError((error) =>
                                        print('Failed to update name: $error'));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),const SizedBox(
                  height: 20,
                ),
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error = ${snapshot.error}');
                    }
                    Map<String, dynamic> data = snapshot.data!.data()!;
                    TextEditingController controller = TextEditingController(
                        text: data[
                            'email']); // Create a TextEditingController
                    return Transform(
                      transform: Matrix4.translationValues(-10, 0.0, 0.0),
                      child: Row(
                        children: [
                          const Text(
                            'البريد الالكتروني: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 220,
                            height: 50,
                            child: TextField(
                              controller:
                                  controller, // Set the controller for the TextField
                              decoration: InputDecoration(
                                labelText:
                                    'البريد الالكتروني', // Label for the TextField
                                border:
                                    const OutlineInputBorder(), // Border for the TextField
                                fillColor: Colors.grey.shade400,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16.0),
                                alignLabelWithHint: true,
                              ),
                              style: const TextStyle(
                                  fontSize:
                                      16), // Style for the text in the TextField
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                // Update the data when the TextField value changes
                                data['email'] = value;

                                // Update Firestore with the new data
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({'email': value})
                                    .then((_) =>
                                        print('Email updated successfully'))
                                    .catchError((error) =>
                                        print('Failed to update Email: $error'));
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),const SizedBox(
                  height: 20,
                ),
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error = ${snapshot.error}');
                    }
                    Map<String, dynamic> data = snapshot.data!.data()!;

                    // Initial TextEditingController with retrieved date or empty string
                    TextEditingController controller = TextEditingController(
                        text: data['date']?.toString() ?? '');

                    return Transform(
                      transform: Matrix4.translationValues(-10, 0.0, 0.0),
                      child: Row(
                        children: [
                          const Text(
                            'تاريخ الميلاد: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 220,
                            height: 50,
                            child: TextField(
                              readOnly: true, // Make the TextField read-only
                              controller: controller,
                              decoration: InputDecoration(
                                labelText:
                                'تاريخ الميلاد', // Label for the TextField
                                border:
                                const OutlineInputBorder(), // Border for the TextField
                                fillColor: Colors.grey.shade400,
                                filled: true,
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                                alignLabelWithHint: true,
                              ),
                              style: const TextStyle(
                                  fontSize:
                                  16), // Style for the text in the TextField
                              textAlign: TextAlign.center,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year - 50, 1, 1), // 50 years ago from today
                                  lastDate: DateTime(DateTime.now().year - 7, 12, 31), // 7 years ago from today (Dec 31st)
                                );

                                if (pickedDate != null) {
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  controller.text = formattedDate;
                                  data['date'] = formattedDate;

                                  // Update Firestore with the new date
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .update({'date': formattedDate})
                                      .then((_) =>
                                      print('Date updated successfully'))
                                      .catchError((error) =>
                                      print('Failed to update Date: $error'));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
        ),
    );
  }
}
