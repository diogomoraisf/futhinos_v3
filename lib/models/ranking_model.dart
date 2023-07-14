import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class RankingModel {
  String? uidHino;
  String? nome;
  String? autor;
  String? ano;
  double? notaMedia;
  int? ordem;
  String? url;
  String? uidTime;
  String? nomeTime;
  String? escudoURL;
  String? urlLetra;
  String? cidade;
  String? uf;
  String? qtdaHinos;
  String? tipo;
  int? qtdaNotas;
  RankingModel({
    this.uidHino,
    this.nome,
    this.autor,
    this.ano,
    this.notaMedia,
    this.ordem,
    this.url,
    this.uidTime,
    this.nomeTime,
    this.escudoURL,
    this.urlLetra,
    this.cidade,
    this.uf,
    this.qtdaHinos,
    this.tipo,
    this.qtdaNotas,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidHino': uidHino,
      'nome': nome,
      'autor': autor,
      'ano': ano,
      'notaMedia': notaMedia,
      'ordem': ordem,
      'url': url,
      'uidTime': uidTime,
      'nomeTime': nomeTime,
      'escudoURL': escudoURL,
      'urlLetra': urlLetra,
      'cidade': cidade,
      'uf': uf,
      'qtdaHinos': qtdaHinos,
      'tipo': tipo,
      'qtdaNotas': qtdaNotas,
    };
  }

  factory RankingModel.fromMap(Map<String, dynamic> map) {
    return RankingModel(
      uidHino: map['uidHino'] != null ? map['uidHino'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      autor: map['autor'] != null ? map['autor'] as String : null,
      ano: map['ano'] != null ? map['ano'] as String : null,
      notaMedia: map['notaMedia'] != null ? map['notaMedia'] as double : null,
      ordem: map['ordem'] != null ? map['ordem'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
      uidTime: map['uidTime'] != null ? map['uidTime'] as String : null,
      nomeTime: map['nomeTime'] != null ? map['nomeTime'] as String : null,
      escudoURL: map['escudoURL'] != null ? map['escudoURL'] as String : null,
      urlLetra: map['urlLetra'] != null ? map['urlLetra'] as String : null,
      cidade: map['cidade'] != null ? map['cidade'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      qtdaHinos: map['qtdaHinos'] != null ? map['qtdaHinos'] as String : null,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      qtdaNotas: map['qtdaNotas'] != null ? map['qtdaNotas'] as int : null,
    );
  }

  RankingModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uidHino = doc.id,
        nome = doc.data()!['nome'],
        autor = doc.data()!['autor'],
        ano = doc.data()!['ano'],
        notaMedia = doc.data()!['notaMedia'],
        ordem = doc.data()!['ordem'],
        url = doc.data()!['url'],
        uidTime = doc.data()!['uidTime'],
        nomeTime = doc.data()!['nomeTime'],
        escudoURL = doc.data()!['escudoURL'],
        urlLetra = doc.data()!['urlLetra'],
        cidade = doc.data()!['cidade'],
        uf = doc.data()!['uf'],
        qtdaHinos = doc.data()!['qtdaHinos'],
        tipo = doc.data()!['tipo'],
        qtdaNotas = doc.data()!['qtdaNotas'];
  String toJson() => json.encode(toMap());

  factory RankingModel.fromJson(String source) =>
      RankingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  RankingModel copyWith({
    String? uidHino,
    String? nome,
    String? autor,
    String? ano,
    double? notaMedia,
    int? ordem,
    String? url,
    String? uidTime,
    String? nomeTime,
    String? escudoURL,
    String? urlLetra,
    String? cidade,
    String? uf,
    String? qtdaHinos,
    String? tipo,
    int? qtdaNotas,
  }) {
    return RankingModel(
      uidHino: uidHino ?? this.uidHino,
      nome: nome ?? this.nome,
      autor: autor ?? this.autor,
      ano: ano ?? this.ano,
      notaMedia: notaMedia ?? this.notaMedia,
      ordem: ordem ?? this.ordem,
      url: url ?? this.url,
      uidTime: uidTime ?? this.uidTime,
      nomeTime: nomeTime ?? this.nomeTime,
      escudoURL: escudoURL ?? this.escudoURL,
      urlLetra: urlLetra ?? this.urlLetra,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
      qtdaHinos: qtdaHinos ?? this.qtdaHinos,
      tipo: tipo ?? this.tipo,
      qtdaNotas: qtdaNotas ?? this.qtdaNotas,
    );
  }
}
