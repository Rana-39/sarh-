import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sarh/Screens/CardsSettings.dart';
import 'package:sarh/Screens/AboutSarh.dart';
import 'package:sarh/Screens/sign_in_screen.dart';

import 'PersonalInformation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(

        ),
        body: SafeArea(
          child: Center(
            child: Expanded(
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Transform(
                            transform: Matrix4.translationValues(-10, 0.0, 0.0),
                            child: const Icon(Icons.chat_bubble_outline_rounded),),
                        GestureDetector(
                            child: const Text(
                              "     اعدادات البطاقات",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CardsSettings()),
                              );
                            }),
                        Transform(
                          transform: Matrix4.translationValues(-40, 0.0, 0.0),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 252, 188, 184),
                    thickness: 5,
                    indent: 7,
                    endIndent: 150,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(-10, 0.0, 0.0),
                          child: const Icon(Icons.chat_bubble_outline_rounded),),
                        GestureDetector(
                            child: const Text(
                              "     عن صرح",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AboutSarh()),
                              );
                            }),
                        Transform(
                          transform: Matrix4.translationValues(-110, 0.0, 0.0),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 255, 217, 114),
                    thickness: 5,
                    indent: 7,
                    endIndent: 150,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(-10, 0.0, 0.0),
                          child: const Icon(Icons.chat_bubble_outline_rounded),),
                        GestureDetector(
                            child: const Text(
                              "     البيانات الشخصية",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const PersonalInformation()),
                              );
                            }),
                        Transform(
                          transform: Matrix4.translationValues(-40, 0.0, 0.0),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 239, 167, 167),
                    thickness: 5,
                    indent: 7,
                    endIndent: 150,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(-10, 0.0, 0.0),
                          child: const Icon(Icons.chat_bubble_outline_rounded),),
                        GestureDetector(
                            child: const Text(
                              "     حذف الحساب",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CardsSettings()),
                              );
                            }),
                        Transform(
                          transform: Matrix4.translationValues(-70, 0.0, 0.0),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 199, 234, 228),
                    thickness: 5,
                    indent: 7,
                    endIndent: 150,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(-10, 0.0, 0.0),
                          child: const Icon(Icons.chat_bubble_outline_rounded),),
                        GestureDetector(
                            child: const Text(
                              "     تسجيل خروج",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          onTap: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              print("Signed Out");
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const Sign_in_screen()));
                            });
                          },),
                        Transform(
                          transform: Matrix4.translationValues(-70, 0.0, 0.0),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 255, 217, 114),
                    thickness: 5,
                    indent: 7,
                    endIndent: 150,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
