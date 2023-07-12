import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:me_mo_ro/views/add_sc.dart';
import 'package:me_mo_ro/views/signup_sc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import 'login_sc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ref = FirebaseDatabase.instance.ref('userdata');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //showing User name in the Top
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.check_circle,
                    color: const Color.fromARGB(255, 11, 110, 14),
                    size: 25,
                  ),
                  title: "Enjoy Your Memories".text.make(),
                  trailing: IconButton(
                      onPressed: () {
                        Get.to(() => LoginScreen());
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        size: 35,
                        color: Color.fromARGB(255, 255, 115, 0),
                      )),
                ),
              ),

              //Builder to show lists of Data
              Expanded(
                child: StreamBuilder(
                    stream: ref.onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.snapshot.children.length > 0) {
                          Map<dynamic, dynamic> map =
                              snapshot.data!.snapshot.value as dynamic;

                          List<dynamic> list = [];
                          list.clear();
                          list = map.values.toList();

                          // returning the object to show in home

                          return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount:
                                  snapshot.data!.snapshot.children.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: PopupMenuButton(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                  child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  ref
                                                      .child(list[index]['id'])
                                                      .remove();
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                ),
                                              ))
                                            ],
                                          )),
                                      Container(
                                        height: 120,
                                        width: 120,
                                        child: Image.network(
                                          list[index]['fileN'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      5.heightBox,
                                      Text(
                                        list[index]['title'],
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 255, 57, 7),
                                            fontSize: 15),
                                      )
                                    ],
                                  )
                                      .box
                                      .color(Color.fromRGBO(255, 255, 255, 1))
                                      .shadow
                                      .rounded
                                      .make(),
                                );
                              });
                        } else {
                          "Add Some Memories".text.black.make();
                        }
                      }
                      return Center(
                        child: (CircularProgressIndicator(
                          color: Colors.deepOrangeAccent,
                        )),
                      );
                    }),
              ),

              //floating action button to add data in Database
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FloatingActionButton(
                        backgroundColor: Color.fromARGB(255, 247, 113, 30),
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                        onPressed: () {
                          Get.to(() => AddScreen());
                        }),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
