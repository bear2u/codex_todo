import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class TodoItem {
  TodoItem(this.title, {this.completed = false});

  final String title;
  bool completed;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<TodoItem> _todos = [];
  final TextEditingController _controller = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTodoList() {
    if (_todos.isEmpty) {
      return const Center(child: Text('No todos'));
    }
    return ListView(
      children: _todos
          .asMap()
          .entries
          .map(
            (e) => CheckboxListTile(
              title: Text(e.value.title),
              value: e.value.completed,
              onChanged: (val) {
                setState(() {
                  e.value.completed = val ?? false;
                });
              },
            ),
          )
          .toList(),
    );
  }

  Widget _buildAddTodo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'New todo'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  _todos.add(TodoItem(_controller.text));
                  _controller.clear();
                  _selectedIndex = 0;
                });
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final completed = _todos.where((t) => t.completed).length;
    final total = _todos.length;
    return Center(
      child: Text('Total Todos: $total\nCompleted: $completed',
          textAlign: TextAlign.center),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildTodoList(),
          _buildAddTodo(),
          _buildStats(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        ],
      ),
    );
  }
}
