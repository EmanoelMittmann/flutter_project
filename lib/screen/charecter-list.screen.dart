import 'package:apiflutter/screen/login.screen.dart';
import 'package:apiflutter/services/firebase/auth_services.dart';
import 'package:flutter/material.dart';

import '../components/header.dart';
import '../components/shelf.dart';
import '../models/character.dart';
import '../services/character_service.dart';

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<Character>> _charactersFuture;
  late List<Character> _characters = [];
  late List<Character> _filteredCharacters = [];
  final firebaseService = AuthServices();

  @override
  void initState() {
    super.initState();
    _charactersFuture = _loadCharacters();
  }

  Future<List<Character>> _loadCharacters() async {
    final service = CharacterService();
    _characters = await service.getCharacters();
    _filteredCharacters = _characters;
    return _characters;
  }

  _filterCharacters(String filter) {
    setState(() {
      _filteredCharacters = _characters
          .where((character) =>
          character.name.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de personagens"),
        actions: [
          TextButton(onPressed: () {
            firebaseService.signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login())
            );
          }, child: Text('Log Out'))
        ],
      ),
      body: Column(
        children: [
          Header(filterCharacters: _filterCharacters),
          Expanded(
            child: FutureBuilder<List<Character>>(
              future: _charactersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                } else {
                  return Shelf(caracters: _filteredCharacters);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
