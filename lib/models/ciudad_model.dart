import 'dart:convert';
import 'package:clima_app/models/ciudad_data.dart';


CiudadesLista ciudadesListaFromJson(String str) => 
    CiudadesLista.fromJson(json.decode(str));

String ciudadesListaToJson(CiudadesLista data) => json.encode(data.toJson());

class CiudadesLista {
    String msg;
    List<Ciudad> data;

    CiudadesLista({
        required this.msg,
        required this.data,
    });

    factory CiudadesLista.fromJson(Map<String, dynamic> json) => CiudadesLista(
        msg: json["msg"],
        data: List<Ciudad>.from(json["data"].map((x) => Ciudad.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

