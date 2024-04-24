import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Models/note_model.dart';
import 'package:noteapp/cubits/show_notes_cubit/show_notes_cubit.dart';
import 'package:noteapp/views/widgets/Custom_Note_Card.dart';

class ListItemCards extends StatelessWidget {
  const ListItemCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowNotesCubit, ShowNotesState>(
      builder: (context, state) {
        List<NoteModel> note =
            BlocProvider.of<ShowNotesCubit>(context).notes ?? [];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.builder(
            itemCount: note.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: NoteCard(
                  note: note[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
