// ignore_for_file: use_build_context_synchronously

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_notes/Interfaces/Screens/Note%20Modify%20Screen/note_modify_screen.dart';
import 'package:my_notes/Interfaces/Widgets/note_delete.dart';
import 'package:my_notes/Models/note_for_listing.dart';
import 'package:my_notes/Services/note_services.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  NoteService get service => GetIt.I<NoteService>();

  late Response<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List of Notes'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const NoteModifyScreen()))
                .then((_) {
              _fetchNotes();
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!_apiResponse.isSuccessful) {
              return const Center(
                child: Text('An error occured'),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: Colors.green,
              ),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.body![index].noteID),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                      context: context,
                      builder: (_) => const NoteDelete(),
                    );

                    if (result) {
                      final deleteResult = await service
                          .deleteNote(_apiResponse.body![index].noteID!);
                      String message;
                      if (deleteResult.body == true) {
                        message = 'The note was deleted';
                      } else {
                        message = 'An error occured';
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                      _apiResponse.body![index].noteTitle ?? 'No title',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        'Last edited on ${formatDateTime(_apiResponse.body![index].latestEditDateTime ?? _apiResponse.body![index].createDateTime!)}'),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => NoteModifyScreen(
                                    noteID: _apiResponse.body![index].noteID,
                                  )))
                          .then((body) {
                        _fetchNotes();
                      });
                    },
                  ),
                );
              },
              itemCount: _apiResponse.body!.length,
            );
          },
        ));
  }
}
