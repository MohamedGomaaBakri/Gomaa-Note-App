part of 'show_notes_cubit.dart';

@immutable
sealed class ShowNotesState {}

final class ShowNotesInitial extends ShowNotesState {}

final class ShowNotesSuccess extends ShowNotesState {}

final class ShowNotesFailure extends ShowNotesState {
  final String errMsg;

  ShowNotesFailure({required this.errMsg});
}
