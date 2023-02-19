import '../model/import.dart';

 // add note function
  Future addNote(String collectionName,noteContent) async {
    await FirebaseFirestore.instance.collection(collectionName).add({
      // key: value here!!
      'NoteContent': noteContent,
    });
  }