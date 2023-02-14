import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/success_error.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  NoteState createState() => NoteState();
}

class NoteState extends State<Note> {
  // note Controller
  final _noteController = TextEditingController();
  // add note function
  Future addNote(String collectionName) async {
    await FirebaseFirestore.instance.collection(collectionName).add({
      // key: value here!!
      'NoteContent': _noteController.text.trim(),
    });
  }

  //Delete Note
  Future deleteNote(String docsID, String collectionName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Define the reference to the document you want to delete
    final DocumentReference documentReference =
        firestore.collection(collectionName).doc(docsID);

// Call the delete method
    await documentReference.delete();
  }

  //Update Note
  Future updateNote(String docsID, String collectionName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Define the reference to the document you want to delete
    final DocumentReference documentReference =
        firestore.collection(collectionName).doc(docsID);

// Call the delete method
    await documentReference.update({
      'NoteContent': _noteController.text.trim(),
    });
  }

  // Dispose
  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    double iconSize = screenWidht * 0.06;
    //double fontSize = screenWidht * 0.02;
    double space = screenHeight * 0.02;
    double padding = screenHeight * 0.02;
    // ! prevent null values
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentUser.email.toString(),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(currentUser.email.toString())
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final notes = snapshot.data!.docs;
            return Dismissible(
              key: Key(
                notes.toString(),
              ),
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  notes.removeAt(snapshot as int);
                });
              },
              child: SizedBox(
                height: screenHeight * 2,
                width: screenWidht,
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenWidht * 0.02),
                        ),
                      ),
                      //color: Colors.blueAccent,
                      margin: EdgeInsets.all(screenWidht * 0.02),
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.all(padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  note.data()['NoteContent'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.defaultDialog(
                                          title: "update note",
                                          content: TextField(
                                            decoration: InputDecoration(
                                              hintText: "Type here to update",
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      screenWidht * 0.02),
                                                ),
                                              ),
                                            ),
                                            controller: _noteController,
                                            enableIMEPersonalizedLearning: true,
                                            onChanged: (value) {
                                              if (value != '') {
                                                updateNote(
                                                    notes[index].id,
                                                    currentUser.email
                                                        .toString());
                                              }
                                            },
                                          ),
                                          actions: [
                                            GestureDetector(
                                              onTap: () {
                                                if (_noteController.text ==
                                                    "") {
                                                  error("Note can't be empty");
                                                } else {
                                                  updateNote(
                                                      notes[index].id,
                                                      currentUser.email
                                                          .toString());

                                                  Get.back();
                                                  success("Note Updated");
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidht * 0.02),
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  size: iconSize,
                                                ),
                                              ),
                                            ),
                                          ]);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.greenAccent,
                                      size: iconSize,
                                    ),
                                  ),
                                  SizedBox(
                                    width: space,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // get docs id/delete note
                                      Get.defaultDialog(
                                        title: "Your note will deleted ",
                                        content: const Text("confirme"),
                                        onConfirm: () {
                                          deleteNote(notes[index].id,
                                              currentUser.email.toString());
                                          Get.back();
                                          success("Note deleted");
                                        },
                                        onCancel: () {
                                          Get.back();
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                      size: iconSize,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Add note",
              content: TextField(
                decoration: InputDecoration(
                  hintText: "Type your note here",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(screenWidht * 0.02),
                    ),
                  ),
                ),
                controller: _noteController,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    if (_noteController.text == "") {
                      error("Note can't be empty");
                    } else {
                      addNote(currentUser.email.toString());

                      Get.back();
                      success("Note added");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(screenWidht * 0.02),
                    ),
                    child: Icon(
                      Icons.add,
                      size: iconSize,
                    ),
                  ),
                ),
              ]);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
