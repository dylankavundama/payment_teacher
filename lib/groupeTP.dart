import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ListGroupe extends StatefulWidget {
  const ListGroupe({super.key});

  @override
  State<ListGroupe> createState() => _ListGroupeState();
}

class _ListGroupeState extends State<ListGroupe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [Membre(nom: 'dyyuyyy', promo: 'G1', sexe: 'M')]),
    );
  }

  Widget Membre({
    String? nom,
    String? sexe,
    String? promo,
  }) {
    return ListTile(
        title: Text('${nom}'),
        subtitle: Text('${promo}'),
        trailing: Text('${sexe}'),
        leading: Icon(
          size: 50,
          LineIcons.userCircle,
        ));
  }
}
