import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:servidordashboard/constraints.dart';
import 'package:servidordashboard/local_data/preferences.dart';
import 'package:servidordashboard/webclients/auth.webclient.dart';

class TermRepository {

  String _getMessageError({@required statusCode}) =>
      responseErrors.containsKey(statusCode) ? responseErrors[statusCode] : "Erro: $statusCode";

  // Informacoes para envio de autenticação
  Future<Map<String, dynamic>> autorizationToken() async {

    // Coleta o token salvo do dispositivo
    String token = await LocalData.getValue(TOKEN_KEY);

    //retorna conteudo do map para inclusão no header
    return {
      "Authorization": "Bearer $token}"
    };
  }

  Future<String> fetchTerms() async {
    try {

      // recupera o map com o token
      var tokenHeader = await autorizationToken();

      // Faz a requisição enviando o token de autorização
      var request = await Dio(WebClient.authBaseOptions).get(
          WebClient.termEndPoint,
          options: Options(headers: tokenHeader)
      );

      if (request.statusCode == 200) {
        return request.data['content'];
      }

    } on DioError catch (e) {
      e.type == DioErrorType.RESPONSE ?
      throw _getMessageError(statusCode: e.response.statusCode) :
      throw _getMessageError(statusCode: e.type.index);
    }
  }
}