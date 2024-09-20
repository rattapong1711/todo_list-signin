import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screen/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 178, 77)),
        useMaterial3: true,
      ),
      home: const SigninScreen(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({super.key});

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _texteditController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _texteditController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void addTodoHandle(BuildContext context, [DocumentSnapshot? doc]) {
    if (doc != null) {
      _texteditController.text = doc['name'];
      _descriptionController.text = doc['detail'];
    } else {
      _texteditController.clear();
      _descriptionController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                doc != null ? Icons.edit : Icons.add,
                color: const Color(0xFF259b24),
              ),
              const SizedBox(width: 8),
              Text(
                doc != null ? "Edit task" : "Add new task",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _texteditController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Task title",
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                      prefixIcon: Icon(Icons.description),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFF44336), // Text color
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (doc != null) {
                  // Update existing task
                  FirebaseFirestore.instance
                      .collection("tasks")
                      .doc(doc.id)
                      .update({
                    'name': _texteditController.text,
                    'detail': _descriptionController.text,
                  }).then((_) {
                    print("Task updated");
                  }).catchError((onError) {
                    print("Failed to update task");
                  });
                } else {
                  // Add new task
                  FirebaseFirestore.instance.collection("tasks").add({
                    'name': _texteditController.text,
                    'detail': _descriptionController.text,
                    'status': false,
                  }).then((res) {
                    print("Task added");
                  }).catchError((onError) {
                    print("Failed to add task");
                  });
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 116, 33, 179), // Text color
              ),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(String id) {
    FirebaseFirestore.instance.collection("tasks").doc(id).delete().then((_) {
      print("Task deleted");
    }).catchError((onError) {
      print("Failed to delete task");
    });
  }

  void toggleStatus(String id, bool status) {
    FirebaseFirestore.instance.collection("tasks").doc(id).update({
      'status': !status,
    }).then((_) {
      print("Task status updated");
    }).catchError((onError) {
      print("Failed to update task status");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true, // Center the title
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("tasks").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No tasks available"));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var task = snapshot.data!.docs[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 5,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    task['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(task['detail']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          task['status']
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: task['status']
                              ? Color.fromARGB(255, 227, 40, 102)
                              : Color.fromARGB(255, 206, 19, 19),
                        ),
                        onPressed: () => toggleStatus(task.id, task['status']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color.fromARGB(255, 127, 195, 125)),
                        onPressed: () => addTodoHandle(context, task),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTask(task.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        backgroundColor: Color.fromARGB(255, 61, 109, 60),
        child: const Icon(Icons.add),
      ),
    );
  }
}