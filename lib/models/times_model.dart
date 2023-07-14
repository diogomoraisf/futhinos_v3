import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TimesModel {
  String? uidTime;
  String? cidade;
  String? escudoURL;
  String? facebook;
  String? instagram;
  String? nomeTime;
  String? qtdaHinos;
  String? tipo;
  String? twitter;
  String? uf;
  String? urlLetra;
  List? hinos;
  TimesModel(
      {this.uidTime,
      this.cidade,
      this.escudoURL,
      this.facebook,
      this.instagram,
      this.nomeTime,
      this.qtdaHinos,
      this.tipo,
      this.twitter,
      this.uf,
      this.urlLetra,
      this.hinos});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidTime': uidTime,
      'cidade': cidade,
      'escudoURL': escudoURL,
      'facebook': facebook,
      'instagram': instagram,
      'nomeTime': nomeTime,
      'qtdaHinos': qtdaHinos,
      'tipo': tipo,
      'twitter': twitter,
      'uf': uf,
      'urlLetra': urlLetra,
      'hinos': hinos
    };
  }

  factory TimesModel.fromMap(Map<String, dynamic> map) {
    return TimesModel(
      uidTime: map['uidTime'] != null ? map['uidTime'] as String : null,
      cidade: map['cidade'] != null ? map['cidade'] as String : null,
      escudoURL: map['escudoURL'] != null ? map['escudoURL'] as String : null,
      facebook: map['facebook'] != null ? map['facebook'] as String : null,
      instagram: map['instagram'] != null ? map['instagram'] as String : null,
      nomeTime: map['nomeTime'] != null ? map['nomeTime'] as String : null,
      qtdaHinos: map['qtdaHinos'] != null ? map['qtdaHinos'] as String : null,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      twitter: map['twitter'] != null ? map['twitter'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      urlLetra: map['urlLetra'] != null ? map['urlLetra'] as String : null,
      hinos: map['hinos'] != null ? map['hinos'] as List : null,
    );
  }

  TimesModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uidTime = doc.id,
        cidade = doc.data()!['cidade'],
        escudoURL = doc.data()!['escudoURL'],
        facebook = doc.data()!['facebook'],
        instagram = doc.data()!['instagram'],
        nomeTime = doc.data()!['nomeTime'],
        qtdaHinos = doc.data()!['qtdaHinos'],
        tipo = doc.data()!['tipo'],
        twitter = doc.data()!['twitter'],
        uf = doc.data()!['uf'],
        urlLetra = doc.data()!['urlLetra'],
        hinos = doc.data()!['hinos'];

  String toJson() => json.encode(toMap());

  factory TimesModel.fromJson(String source) =>
      TimesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TimesModel copyWith(
      {String? uidTime,
      String? cidade,
      String? escudoURL,
      String? facebook,
      String? instagram,
      String? nomeTime,
      String? qtdaHinos,
      String? tipo,
      String? twitter,
      String? uf,
      String? urlLetra,
      List? hinos}) {
    return TimesModel(
        uidTime: uidTime ?? this.uidTime,
        cidade: cidade ?? this.cidade,
        escudoURL: escudoURL ?? this.escudoURL,
        facebook: facebook ?? this.facebook,
        instagram: instagram ?? this.instagram,
        nomeTime: nomeTime ?? this.nomeTime,
        qtdaHinos: qtdaHinos ?? this.qtdaHinos,
        tipo: tipo ?? this.tipo,
        twitter: twitter ?? this.twitter,
        uf: uf ?? this.uf,
        urlLetra: urlLetra ?? this.urlLetra,
        hinos: hinos ?? this.hinos);
  }
}
