// To parse this JSON data, do

import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? id;
  String number;
  String code;

  Users({
    this.id,
    required this.number,
    required this.code,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    id: json["id"],
    number: json["number"],
    code: json["code"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "number": number,
    "code": code,
  };
}
