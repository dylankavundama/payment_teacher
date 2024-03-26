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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('les membres du groupe'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Membre(nom: 'Munanga Bonso lievin', sexe: 'M'),
          Membre(nom: 'Mbusa keukeu David', sexe: 'M'),
          Membre(nom: 'Wahabu djuma navid', sexe: 'M'),
          Membre(nom: 'Bakengane kabene josue', sexe: 'M'),
          Membre(nom: 'Kabuo lusenge ruth', sexe: 'F'),
          Membre(nom: 'Muhirwa ruboneka David', sexe: 'M'),
          Membre(nom: 'Sadiki sebujangwe lucien', sexe: 'M'),
          Membre(nom: 'Nyandwi Ndiseka bonardo', sexe: 'M'),
          Membre(nom: 'Bisimwa buranga malick', sexe: 'M'),
          Membre(nom: 'Mwamba elikya josue', sexe: 'M'),
          Membre(nom: 'Kalamo mushomo junior', sexe: 'M'),
          Membre(nom: 'Musimwa baganda josephine', sexe: 'F'),
          Membre(nom: 'Rhusimana Kalinda divine', sexe: 'F'),
          Membre(nom: 'Sarah murisho judith', sexe: 'F'),
          Membre(nom: 'Eleka Nsele jeannette', sexe: 'F'),
          Membre(nom: 'Tumaini sindayi samuel', sexe: 'M'),
          Membre(nom: 'Kavira sikiminywa gloria', sexe: 'F'),
        ]),
      ),
    );
  }

  Widget Membre({
    String? nom,
    String? sexe,
  }) {
    return ListTile(
        title: Text('${nom}'),
        subtitle: Text(''),
        trailing: Text('${sexe}'),
        leading: const Icon(
          size: 50,
          LineIcons.userCircle,
        ));
  }
}
