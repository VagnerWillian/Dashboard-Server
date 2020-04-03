import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:servidordashboard/constraints.dart';
import 'package:servidordashboard/local_data/preferences.dart';
import 'package:servidordashboard/validators/general_validator.dart';
import 'package:servidordashboard/webclients/auth.webclient.dart';

class Auth {

  // Verifica se o usuario esta logado
  static Future<bool> isLogged() async => await LocalData.getValue(TOKEN_KEY) == null ? false : true;

  // Informacoes para envio de autenticação
  Future<Map<String, dynamic>> autorizationMap(u, p) async {
    // Colata dados do sistema
    String _device_ID = await _getDeviceId();

    //retorna conteudo do map para inclusão no header
    return  {
      "login": u,
      "pass": p,
      "remember": "true",
      "device_id": _device_ID,
      "push_notification_token": "jkdsfhkajsdhfkjsdahyf78sadf8asd6f87asd6f87sad6f78sad8fsd"
    };
  }

  // Retorna erros de resposta de requisição
  String _getMessageError({@required statusCode}) => responseErrors.containsKey(statusCode) ? responseErrors[statusCode] : "Erro: $statusCode";

  signIn({@required String user, @required String pass, Function onSucess, Function onFailure}) async {

    // Valida os dados digitados no campo
    if (GeneralValidator.loginValidator(user: user, pass: pass)) {
      // Se for válido ele faz a requisição.
      await _requestAsToken(user: user, pass: pass).then((token) {
        LocalData.setValue(KEY: TOKEN_KEY, value: token);
        onSucess();
      }).catchError((err) {
        onFailure(err.toString());
      });
    } else {
      onFailure("Usuário e senha inválidos");
    }
  }

  // Solicita um token
  Future<String> _requestAsToken({@required String user, @required String pass}) async {
    try {
      var request = await Dio(WebClient.generalBaseOptions).post(
          WebClient.loginEndPoint,
          data: await autorizationMap(user, pass)
      );

      if (request.statusCode == 200) {
        return request.data['token'];
      }
    }
    on DioError catch (e) {
      e.type == DioErrorType.RESPONSE ?
      throw _getMessageError(statusCode: e.response.statusCode) :
      throw _getMessageError(statusCode: e.type.index);
    }
  }

  Future<String> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}