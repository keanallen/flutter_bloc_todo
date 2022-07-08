import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewTodo extends StatelessWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController idCtrl = TextEditingController();
    TextEditingController titleCtrl = TextEditingController();
    TextEditingController descriptionCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new To Do"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _inputField(textController: idCtrl, label: "Task #"),
            _inputField(textController: titleCtrl, label: "Title"),
            _inputField(textController: descriptionCtrl, label: "Description"),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Save Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField _inputField(
      {required TextEditingController textController, required String label}) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(labelText: label),
    );
  }
}
