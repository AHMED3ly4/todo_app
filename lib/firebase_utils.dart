import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseUtils{

  static CollectionReference<TaskModel> getTaskCollection()=>FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
      fromFirestore: (snapshot, _) =>TaskModel.fromJson(snapshot.data()!),
      toFirestore: (task, _) => task.toJson(),
  );

  static Future<void> addTaskToFireBase(TaskModel task)  {
    final  CollectionReference tasksCollection = getTaskCollection();
    final DocumentReference doc = tasksCollection.doc();
    task.id =doc.id;
    return doc.set(task);
  }

  static Future <List<TaskModel>> getAllTasksFromFireStore()async {
    final tasksCollection = getTaskCollection();
    final querySnapShot = await tasksCollection.get();
    return querySnapShot.docs.map((doc) => doc.data()).toList();
  }

}