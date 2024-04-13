import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sarh/User_Screens/consultations.dart';
import '../reusable_widgets/reusable_widget.dart';

class SpecialistDetails extends StatefulWidget {
  final String name;
  final String major;
  final String genders;
  final String experience;
  const SpecialistDetails({
    super.key,
    required this.name,
    required this.major,
    required this.genders,
    required this.experience,
  });

  @override
  State<SpecialistDetails> createState() => _SpecialistDetailsState();
}

class _SpecialistDetailsState extends State<SpecialistDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Transform(
            transform: Matrix4.translationValues(-10, 43, 0.0),
            child: const Text(
              'استشارات فورية',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/صرح.png'),
                    fit: BoxFit.fill)),
          ),
          toolbarHeight: 250,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors
                        .grey[300], // You can adjust the shade of grey as needed
                    borderRadius:
                        BorderRadius.circular(8), // Optional: Adds rounded corners
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                widget.major,
                                style: const TextStyle(color: Colors.black),
                              ),
                              Text(
                                widget.genders,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       Row(
                        children: [
                          const Text(
                            'نوع الجلسات:\n'
                            'مخاطبة',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Text(
                            'الخبرة:\n'
                            '${widget.experience} سنوات',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'تقديم الجلسات:\n'
                            'صوتية',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text(
                            'اللغة:\n'
                            'العربية',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Row(
                        children: [
                          Text(
                            '15 دقيقة',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 167, 232, 189),
                      border: Border.all(
                        color: Colors.grey.shade300, // Border color
                        width: 1,
                      ),
                      ),
                    child: const Icon(Icons.person_2_outlined),
                  ),
                ),
              ],
            ),
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                Map<String, dynamic> data = snapshot.data!.data()!;
                String firstName =
                    data['first name'] ?? ''; // Get the first name from data

                return Transform(
                  transform: Matrix4.translationValues(-50,0,0),
                  child: buttons(context,
                    58.0,
                    220.0,
                    "الحجز",
                        () async {
                      // Get current date
                      DateTime now = DateTime.now();
                      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

                      // Create consultation data
                      Map<String, dynamic> consultationData = {
                        'specialist_name': widget.name,
                        'specialist_major': widget.major,
                        'consultation_date': formattedDate,
                        // Add user name if available
                        'user_name': firstName, // Replace with actual user name retrieval
                      };

                      // Add consultation to Firestore
                      await FirebaseFirestore.instance
                          .collection('consultations')
                          .add(consultationData);

                      // Display success message or navigate (optional)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم حجز الاستشارة بنجاح!'),
                        ),
                      );
                      // You can consider navigating to Consultations screen here
                    },),
                );
              },
            ),
          ],
        ),

    );
  }
}
