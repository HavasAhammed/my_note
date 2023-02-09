// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/Interfaces/Screens/Note%20Modify%20Screen/note_modify_screen.dart';
import 'package:my_notes/Interfaces/Widgets/note_delete.dart';
import 'package:my_notes/Models/note.dart';
import 'package:my_notes/Providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  // NoteService get service => GetIt.I<NoteService>();

  // late Response<List<Note>> _apiResponse;
  // bool _isLoading = false;

  Note? note;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<NoteProvider>(context, listen: false)
          .getAllNotes(context);
    });
  }

  // _fetchNotes() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   _apiResponse = await service.getNotesList();

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, _) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('List of Notes'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NoteModifyScreen(
                          note: note,
                          noteID: null,
                        )));
              },
              child: const Icon(Icons.add),
            ),
            body: noteProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : noteProvider.notes.isEmpty
                    ? const Center(
                        child: Text(
                          'No Notes',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          color: Colors.green,
                        ),
                        itemBuilder: (_, index) {
                          return Dismissible(
                            key: ValueKey(noteProvider.notes[index].noteID),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {},
                            confirmDismiss: (direction) async {
                              final result = await showDialog(
                                context: context,
                                builder: (_) => const NoteDelete(),
                              );

                              if (result) {
                                final deleteResult =
                                    await Provider.of<NoteProvider>(context,
                                            listen: false)
                                        .deleteNote(context, note!);
                                String message;
                                if (deleteResult.body == true) {
                                  message = 'The note was deleted';
                                } else {
                                  message = 'An error occured';
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(message),
                                  duration: const Duration(milliseconds: 1000),
                                ));
                                return deleteResult.body ?? false;
                              }
                              return result;
                            },
                            background: Container(
                              color: Colors.red,
                              child: const Align(
                                alignment: Alignment.center,
                                child: Icon(CupertinoIcons.delete),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                noteProvider.notes[index].noteTitle ??
                                    'No title',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              subtitle: Text(
                                  'Last edited on ${formatDateTime((noteProvider.notes[index].latestEditDateTime ?? noteProvider.notes[index].createDateTime!))}'),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NoteModifyScreen(
                                          note: noteProvider.notes[index],
                                          noteID:
                                              noteProvider.notes[index].noteID,
                                        )));
                              },
                            ),
                          );
                        },
                        itemCount: noteProvider.notes.length,
                      ));
      },
    );
  }
}
