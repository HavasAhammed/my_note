// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_notes/Interfaces/Widgets/custom_textfield.dart';
import 'package:my_notes/Models/note.dart';
import 'package:my_notes/Models/note_insert.dart';
import 'package:my_notes/Services/note_services.dart';

class NoteModifyScreen extends StatefulWidget {
  const NoteModifyScreen({super.key, this.noteID});

  final String? noteID;

  @override
  State<NoteModifyScreen> createState() => _NoteModifyScreenState();
}

class _NoteModifyScreenState extends State<NoteModifyScreen> {
  bool get isEditing => widget.noteID != null;

  NoteService get noteService => GetIt.I<NoteService>();

  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  bool isLoading = false;

  String? errorMessage;

  Note? note;

  @override
  void initState() {
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      noteService.getNote(widget.noteID!).then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occured';
        }
        note = response.data;
        titleController.text = note!.noteTitle ?? 'No title';
        contentController.text = note!.noteContent ?? 'No content';
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Create Note')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                            setState(() {
                              isLoading = true;
                            });
                            final note = NoteManipulation(
                                noteTitle: titleController.text,
                                noteContent: contentController.text);
                            final result = await noteService.updateNote(
                                widget.noteID!, note);
                            setState(() {
                              isLoading = false;
                            });
                            const title = 'Done';
                            final text = result.error
                                ? (result.errorMessage ?? 'An error occured')
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
                            setState(() {
                              isLoading = true;
                            });
                            final note = NoteManipulation(
                                noteTitle: titleController.text,
                                noteContent: contentController.text);
                            final result = await noteService.createNote(note);
                            setState(() {
                              isLoading = false;
                            });
                            const title = 'Done';
                            final text = result.error
                                ? (result.errorMessage ?? 'An error occured')
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
  }
}
