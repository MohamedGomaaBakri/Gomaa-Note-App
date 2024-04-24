import 'package:flutter/material.dart';
import 'package:noteapp/constants.dart';
import 'package:noteapp/views/widgets/Custom_Search_Icon.dart';
import 'package:noteapp/views/widgets/List_Item_cards.dart';
import 'package:noteapp/views/widgets/Modal_bottom_sheet.dart';

class NoteVeiw extends StatelessWidget {
  const NoteVeiw({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes ',
        ),
        actions: const [
          SearchIcon(),
        ],
      ),
      body: const ListItemCards(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const ModalBottomSheet();
              });
        },
        backgroundColor: kprimaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
