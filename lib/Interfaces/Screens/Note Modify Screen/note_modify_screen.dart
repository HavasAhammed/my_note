// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_notes/Interfaces/Widgets/custom_textfield.dart';
import 'package:my_notes/Models/note.dart';
import 'package:my_notes/Providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteModifyScreen extends StatefulWidget {
  const NoteModifyScreen({super.key, this.noteID, this.note});

  final String? noteID;
  final Note? note;

  @override
  State<NoteModifyScreen> createState() => _NoteModifyScreenState();
}

class _NoteModifyScreenState extends State<NoteModifyScreen> {
  bool get isEditing => !(widget.noteID == null);

  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  String? errorMessage;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await Provider.of<NoteProvider>(context, listen: false)
          .getSingleNote(context,widget.note!);
    });
    if (isEditing) {
      titleController.text = widget.note!.noteTitle ?? '';
      contentController.text = widget.note!.noteContent ?? 'hi';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(builder: (context, noteProvider, _) {
      return Scaffold(
        appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Create Note')),
        body: noteProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    CustomTextField(
                        hintText: 'Note Title',
                        icon: Icons.title,
                        controller: titleController),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextField(
                        hintText: 'Note Content',
                        icon: Icons.content_paste,
                        controller: contentController),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (isEditing) {
                              // update note in api

                              final note = Note(
                                  noteTitle: titleController.text,
                                  noteContent: contentController.text);
                              final result = await noteProvider.updateNote(
                                  context: context, note: note);

                              const title = 'Done';
                              final text = !result.isSuccessful
                                  ? 'An error occured'
                                  : 'Your note was updated';

                              await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text(title),
                                  content: Text(text),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Ok'))
                                  ],
                                ),
                              ).then((data) {
                                Navigator.of(context).pop();
                              });
                            } else {
                              // create note in api

                              final note = Note(
                                  noteTitle: titleController.text,
                                  noteContent: contentController.text);
                              final result = await noteProvider.createNote(
                                  context: context, note: note);

                              const title = 'Done';
                              final text = !result.isSuccessful
                                  ? 'An error occured'
                                  : 'Your note was created';

                              await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text(title),
                                  content: Text(text),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Ok'))
                                  ],
                                ),
                              ).then((data) {
                                Navigator.of(context).pop();
                              });
                            }
                          },
                          child: const Text('Submit')),
                    )
                  ],
                ),
              ),
      );
    });
  }
}
