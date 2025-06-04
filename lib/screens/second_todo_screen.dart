import 'package:flutter/material.dart';

class SecondTodoScreen extends StatefulWidget {
  const SecondTodoScreen({super.key});

  @override
  State<SecondTodoScreen> createState() => _SecondTodoScreenState();
}

class _SecondTodoScreenState extends State<SecondTodoScreen> {
  final List<String> _todos = <String>[];

  Future<void> _addTodo() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter todo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) {
      setState(() => _todos.add(result.trim()));
    }
  }

  Future<void> _editTodo(int index) async {
    final controller = TextEditingController(text: _todos[index]);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Todo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter todo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) {
      setState(() => _todos[index] = result.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Todo')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_todos[index]),
          onTap: () => _editTodo(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
