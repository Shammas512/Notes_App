import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController type = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  List<String> notes = [];
  saveNotes() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      notes.add("${type.text}:${title.text}:${content.text}");
      prefs.setStringList('Notes', notes);
    });
    title.clear();
    content.clear();
    type.clear();
  }

  loadtasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notes = prefs.getStringList('Notes') ?? [];
    });
  }

  deleteNotes(int bhaichara) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notes.removeAt(bhaichara);
      prefs.setStringList('Notes', notes);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadtasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shammaz Notes"),
      ),
      body: notes.isEmpty? const Center(child: Text("Add Some New Notes"),):ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(notes[index].split(":")[1]),
              subtitle: Text(notes[index].split(":")[2]),
              leading: Text(notes[index].split(":")[0]),
              trailing: IconButton(
                  onPressed:()=> deleteNotes(index), icon: const Icon(Icons.delete)),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => shownoteofadd(context),
        child:const Icon(Icons.add),
      ),
    );
  }

  shownoteofadd(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Notes"),
            content: Column(
              children: [
                TextField(
                  
                  controller: type,
                  decoration: const InputDecoration(labelText: "Enter Type"),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Enter Title"),
                  controller: title,
                ),
                TextField(
                  controller: content,
                  decoration: const InputDecoration(labelText: "Enter Content"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    saveNotes();
                    Navigator.pop(context);
                  },
                  child: const Text('save'))
            ],
          );
        });
  }
}
