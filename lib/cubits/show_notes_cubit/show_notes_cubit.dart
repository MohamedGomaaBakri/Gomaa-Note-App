import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:noteapp/Models/note_model.dart';
import 'package:noteapp/constants.dart';

part 'show_notes_state.dart';

class ShowNotesCubit extends Cubit<ShowNotesState> {
  ShowNotesCubit() : super(ShowNotesInitial());
  List<NoteModel>? notes;
  shownotes() {
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      notes = notesBox.values.toList();
      emit(ShowNotesSuccess());
    } catch (e) {
      emit(ShowNotesFailure(errMsg: e.toString()));
    }
  }
}
