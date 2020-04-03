import 'package:flutter/material.dart';

// =================== COLORS ==========================
Color maincolor = Color.fromRGBO(35, 32, 64, 1);


// ========================URL========================
final BASEURL = "http://api.advaud.com.br/homologa-vagner-v1";


// ============ KEY SHAREDPREFERENCES =================
final TOKEN_KEY = "TOKEN_KEY";


// ============ RESPONSE ERROS ========================
Map<int, dynamic> get responseErrors => {
  // Errors from Dio
  0 :   "Tempo de limite esgotado",
  1 :   "Tempo de envio esgotado",
  2 :   "Tempo de recebimento esgotado",
  5 :   "Verifique sua conexão com a internet",

  // Erros from response
  400 : "Falha na autenticação",
  408 : "Tempo limite esgotado",
  502 : "Porta de entrada ruim",
  504 : "Tempo limite da porta de entrada",
  404 : "Não encontrado",
  500 : "Erro no servidor interno",
  503 : "Servido indisponível"
};