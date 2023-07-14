// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotasModel {
  String? uidNota;
  double? nota;
  Timestamp? dataCriacao;
  Timestamp? dataModificacao;
  NotasModel({this.uidNota, this.nota, this.dataCriacao, this.dataModificacao});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidNota': uidNota,
      'nota': nota,
      'dataCriacao': dataCriacao,
      'dataModificacao': dataModificacao
    };
  }

  factory NotasModel.fromMap(Map<String, dynamic> map) {
    return NotasModel(
      uidNota: map['uidNota'] != null ? map['uidNota'] as String : null,
      nota: map['nota'] != null ? map['nota'] as double : null,
      dataCriacao:
          map['dataCriacao'] != null ? map['dataCriacao'] as Timestamp : null,
      dataModificacao: map['dataModificacao'] != null
          ? map['dataModificacao'] as Timestamp
          : null,
    );
  }

  NotasModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uidNota = doc.id,
        nota = doc.data()!['nota'],
        dataCriacao = doc.data()!['dataCriacao'],
        dataModificacao = doc.data()!['dataModificacao'];

  String toJson() => json.encode(toMap());

  factory NotasModel.fromJson(String source) =>
      NotasModel.fromMap(json.decode(source) as Map<String, dynamic>);

  NotasModel copyWith({
    String? uidNota,
    double? nota,
    Timestamp? dataCriacao,
    Timestamp? dataModificacao,
  }) {
    return NotasModel(
        uidNota: uidNota ?? this.uidNota,
        nota: nota ?? this.nota,
        dataCriacao: dataCriacao ?? this.dataCriacao,
        dataModificacao: dataModificacao ?? this.dataModificacao);
  }
}
