import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/colors.dart';
import 'package:get/get.dart';
import 'auth/note_operation.dart';
import 'model/bg.dart';
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
 // String textNote = _noteController.text.trim();
 // addNote(collectionName, _noteController) {}

  // Future addNote(String collectionName,) async {
  //   await FirebaseFirestore.instance.collection(collectionName).add({
  //     // key: value here!!
  //     'NoteContent': _noteController.text.trim(),
  //   });
  // }

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
        backgroundColor: Colors.deepPurple,
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
                  color: MyColors.whiteColor,
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
            return SizedBox(
              height: screenHeight * 2,
              width: screenWidht,
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Container(
                    decoration: BoxDecoration(
                      gradient: noteBG,
                      //  color: const Color.fromARGB(255, 167, 132, 233),
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenWidht * 0.02),
                      ),
                    ),
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
                                // Update note here
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
                                              updateNote(notes[index].id,
                                                  currentUser.email.toString());
                                            }
                                          },
                                        ),
                                        actions: [
                                          GestureDetector(
                                            onTap: () {
                                              if (_noteController.text == "") {
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
                                                color: Colors.deepPurple,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidht * 0.02),
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                size: iconSize,
                                                color: Colors.white,
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
                                // delete note
                                GestureDetector(
                                  onTap: () {
                                    // get docs id/delete note
                                    Get.defaultDialog(
                                      title: "Your note will deleted ",
                                      content: const Text(""),

                                      // Cancel & confirme button
                                      actions: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.blue,
                                            size: iconSize,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            deleteNote(notes[index].id,
                                                currentUser.email.toString());
                                            Get.back();
                                            success("Note deleted");
                                          },
                                          child: Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.red,
                                            size: iconSize,
                                          ),
                                        ),
                                      ],
                                      // onConfirm: () {
                                      //   deleteNote(notes[index].id,
                                      //       currentUser.email.toString());
                                      //   Get.back();
                                      //   success("Note deleted");
                                      // },
                                      // onCancel: () {

                                      // },
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
            );
          },
        ),
      ),
      // Add note here
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Get.defaultDialog(
              title: "Add note",
              content: SizedBox(
                height: screenHeight * 0.1,
                width: screenWidht,
                child: TextField(
                  decoration: InputDecoration(
                    //counterText: "${_enteredText.length}/120",
                    hintText: "Type your note here",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenWidht * 0.02),
                      ),
                    ),
                  ),
                  controller: _noteController,
                  autocorrect: true,
                  autofocus: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(120),
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    if (_noteController.text == "") {
                      error("Note can't be empty");
                    } else {
                      addNote(currentUser.email.toString(), _noteController.text.trim());

                      Get.back();
                      success("Note added");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(screenWidht * 0.02),
                    ),
                    child: Icon(
                      Icons.add,
                      size: iconSize,
                      color: Colors.greenAccent,
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
