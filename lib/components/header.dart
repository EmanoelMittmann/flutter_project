import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.filterCharacters});

  final Function(String text) filterCharacters;

  @override
  HeaderState createState() => HeaderState();
}

class HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        onChanged: widget.filterCharacters,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Filtrar",
        ),
      ),
    );
  }
}
