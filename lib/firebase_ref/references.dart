import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;

final questionPaperRF = fireStore.collection('questionPapers');
Reference get firebaseStorage => FirebaseStorage.instance.ref();
final userRF = fireStore.collection('users');
DocumentReference questionRF(
        {required String paperId, required String questionId}) =>
    questionPaperRF.doc(paperId).collection('questions').doc(questionId);
DocumentReference answerRF({
  required String paperId,
  required String questionId,
  required String answerID,
}) =>
    questionPaperRF
        .doc(paperId)
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(answerID);
