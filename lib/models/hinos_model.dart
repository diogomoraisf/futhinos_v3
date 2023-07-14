// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class HinosModel {
  String? uidHino;
  String? ano;
  String? autor;
  String? nome;
  String? url;
  int? ordem;
  double? notaMedia;
  HinosModel(
      {this.uidHino,
      this.ano,
      this.autor,
      this.nome,
      this.url,
      this.ordem,
      this.notaMedia});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidHino': uidHino,
      'ano': ano,
      'autor': autor,
      'nome': nome,
      'url': url,
      'ordem': ordem,
      'notaMedia': notaMedia
    };
  }

  factory HinosModel.fromMap(Map<String, dynamic> map) {
    return HinosModel(
        uidHino: map['uidHino'] != null ? map['uidHino'] as String : null,
        ano: map['ano'] != null ? map['ano'] as String : null,
        autor: map['autor'] != null ? map['autor'] as String : null,
        nome: map['nome'] != null ? map['nome'] as String : null,
        url: map['url'] != null ? map['url'] as String : null,
        ordem: map['ordem'] != null ? map['ordem'] as int : null,
        notaMedia:
            map['notaMedia'] != null ? map['notaMedia'] as double : null);
  }

  HinosModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uidHino = doc.id,
        ano = doc.data()!['ano'],
        autor = doc.data()!['autor'],
        nome = doc.data()!['nome'],
        url = doc.data()!['url'],
        ordem = doc.data()!['ordem'],
        notaMedia = doc.data()!['notaMedia'];

  String toJson() => json.encode(toMap());

  factory HinosModel.fromJson(String source) =>
      HinosModel.fromMap(json.decode(source) as Map<String, dynamic>);

  HinosModel copyWith(
      {String? uidHino,
      String? ano,
      String? autor,
      String? nome,
      String? url,
      int? ordem,
      double? notaMedia}) {
    return HinosModel(
        uidHino: uidHino ?? this.uidHino,
        ano: ano ?? this.ano,
        autor: autor ?? this.autor,
        nome: nome ?? this.nome,
        url: url ?? this.url,
        ordem: ordem ?? this.ordem,
        notaMedia: notaMedia ?? this.notaMedia);
  }
}
