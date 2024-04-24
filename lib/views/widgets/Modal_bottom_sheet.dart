import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/Models/note_model.dart';
import 'package:noteapp/cubits/addNoteCubit/add_note_cubit_cubit.dart';
import 'package:noteapp/cubits/show_notes_cubit/show_notes_cubit.dart';
import 'package:noteapp/views/widgets/Custom_Button.dart';
import 'package:noteapp/views/widgets/Custom_Text_Field.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubitCubit(),
      child: BlocConsumer<AddNoteCubitCubit, AddNoteState>(
        listener: (context, state) {
          if (state is AddNoteFailure) {
            debugPrint(state.errMsg);
          }
          if (state is AddNoteSuccess) {
            BlocProvider.of<ShowNotesCubit>(context).shownotes();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const SingleChildScrollView(
              child: AddNote(),
            ),
          );
        },
      ),
    );
  }
}

class AddNote extends StatefulWidget {
  const AddNote({
    super.key,
  });

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formkey = GlobalKey();
  String? title, subtitle;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formkey,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            hinttext: 'Title',
            onSaved: (p0) {
              title = p0;
            },
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            hinttext: 'Content',
            maxlines: 3,
            onSaved: (p0) {
              subtitle = p0;
            },
          ),
          const SizedBox(
            height: 32,
          ),
          const ColorsList(),
          const SizedBox(
            height: 32,
          ),
          BlocBuilder<AddNoteCubitCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    var currentDate = DateTime.now();
                    var formattedDate = DateFormat('d-M-y').format(currentDate);
                    NoteModel note = NoteModel(
                        title: title!,
                        subtitle: subtitle!,
                        date: formattedDate,
                        color: Colors.amber.value);
                    BlocProvider.of<AddNoteCubitCubit>(context).addnote(note);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActive, required this.color});
  final bool isActive;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: color,
            ),
          )
        : CircleAvatar(
            radius: 30,
            backgroundColor: color,
          );
  }
}

class ColorsList extends StatefulWidget {
  const ColorsList({super.key});

  @override
  State<ColorsList> createState() => _ColorsListState();
}

class _ColorsListState extends State<ColorsList> {
  int currentIndex = 0;
  List<Color> colors = [
    const Color(0xffd7297f),
    const Color(0xff5e67a5),
    const Color(0xff8d70bd),
    const Color(0xff959fae),
    const Color(0xffd42ee6),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                currentIndex = index;
                BlocProvider.of<AddNoteCubitCubit>(context).color =
                    colors[index];
                setState(() {});
              },
              child: ColorItem(
                color: colors[index],
                isActive: currentIndex == index,
              ),
            ),
          );
        },
      ),
    );
  }
}
