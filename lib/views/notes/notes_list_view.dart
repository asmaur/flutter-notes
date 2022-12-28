import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import '../../services/crud/notes_services.dart';
import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  const NotesListView({Key? key, required this.notes, required this.onDeleteNote, required this.onTap,}) : super(key: key);

  final List<DatabaseNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: ()async{
              final shouldDelete = await showDeleteDialog(context);
              if(shouldDelete){
                onDeleteNote(note);
              }
            },
            icon: const Icon(Icons.delete),
          ),
          onTap: (){
            onTap(note);
          },
        );
      },
    );;
  }
}
