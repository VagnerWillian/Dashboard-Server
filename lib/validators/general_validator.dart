import 'package:flutter/material.dart';

class GeneralValidator{

  static bool loginValidator({@required String user, @required String pass}) => !(user.isEmpty || user.length < 3 && pass.isEmpty || pass.length < 3);

}