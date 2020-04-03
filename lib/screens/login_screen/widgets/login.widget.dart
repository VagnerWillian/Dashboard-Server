
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servidordashboard/modules/auth_module.dart';
import 'package:servidordashboard/screens/main_screen/main.screen.dart';
import 'package:servidordashboard/validators/general_validator.dart';

enum _status{
  SHOW, LOADING, CHECK, ERROR
}

class LoginWidget extends StatefulWidget {

  // Key received from MainScreen for show the SnackBar
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  // received animatedContainer Funcion
  VoidCallback _animateContainer;

  // Contructor with ScaffoldKey
  LoginWidget(this._scaffoldKey, this._animateContainer);

  // Instance login
  Auth _authUser = Auth();

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {


  // TextboxFields controllers
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  var _actuallyWidget = _status.SHOW;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 255,
      child: _actuallyWidget  == _status.SHOW
          ? loginWidget(context)
          :  _actuallyWidget == _status.CHECK ? checkWidget() : loadingWidget(),
    );
  }

  Widget loginWidget(context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
       Expanded(
         flex: 3,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
             Flexible(
               child: Container(
                   padding: EdgeInsets.all(20),
                   child: Text("Entre com a sua conta", textAlign: TextAlign.center,
                     style: TextStyle(fontSize: 20),
                   )),
             ),
             Flexible(
               child: Container(
                 padding: EdgeInsets.all(10),
                 margin: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                     color: Colors.grey[200],
                     borderRadius: BorderRadius.circular(5)
                 ),
                 child: TextFormField(
                   controller: _userController,
                   decoration: InputDecoration(
                       border: InputBorder.none,
                       hintText: "Nome de usuario"
                   ),
                   textAlign: TextAlign.center,
                 ),
               ),
             ),
             Flexible(
               child: Container(
                 padding: EdgeInsets.all(10),
                 margin: EdgeInsets.symmetric(horizontal: 10),
                 decoration: BoxDecoration(
                     color: Colors.grey[200],
                     borderRadius: BorderRadius.circular(5)
                 ),
                 child: TextFormField(
                   controller: _passController,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: "Senha",
                   ),
                   obscureText: true,
                   textAlign: TextAlign.center,
                 ),
               ),
             ),
           ],
         ),
       ),
        Flexible(
          child: SizedBox(
            height: 65,
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
              onPressed: ()=>asAuth(), // Login Function
              color: Colors.pink[800],
              child: Text("ENTRAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
            ),
          ),
        ),
      ],
    );
  }

  Widget loadingWidget()=>Container(width: 50, height: 50, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pink[800]),),);
  Widget checkWidget()=>CircleAvatar(backgroundColor: Colors.greenAccent, child: Icon(Icons.check, color: Colors.white, size: 50,),);

  // ============================================ FUNCTIONS
 asAuth()async{
    // Animate for loading received in constructor
    widget._animateContainer();
    setStatus(status: _status.LOADING);

    // Trying auth
    String user = _userController.text;
    String pass = _passController.text;

    await widget._authUser.signIn(user: user, pass: pass, onFailure: onFailure, onSucess: onSucess);
  }

  onSucess() async {
    await Future.delayed(Duration(seconds: 3));

    // Animate for loading received in constructor
    setStatus(status: _status.CHECK);
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
  }

  onFailure(String message){
    widget._animateContainer();
    setStatus(status: _status.SHOW);
    widget._scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(message, style: TextStyle(color: Colors.white),),
          duration: Duration(seconds: 3),
        )
    );
  }

  setStatus({status}){
    setState(() {
      _actuallyWidget = status;
    });
  }

}