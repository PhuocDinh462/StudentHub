import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController controller;

  const SearchBox({super.key, required this.controller});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(1000),
            ),
            child: TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: text_700,
                  size: 20,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 20,
                  minWidth: 25,
                ),
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: text_500,
                ),
              ),
              onChanged: (value) {
                // Add your logic here if needed
              },
            ),
          ),
        ],
      ),
    );
  }
}
