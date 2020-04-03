import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:servidordashboard/constraints.dart';
import 'package:servidordashboard/modules/auth_module.dart';
import 'package:servidordashboard/screens/login_screen/widgets/login.widget.dart';
import 'package:servidordashboard/screens/main_screen/main.screen.dart';
import 'package:servidordashboard/screens/main_screen/tiles/server_menu.tile.dart';

class SplashLoginScreen extends StatefulWidget {
  @override
  _SplashLoginScreenState createState() => _SplashLoginScreenState();
}

class _SplashLoginScreenState extends State<SplashLoginScreen> {
  bool isShowText = false;

  // AnimatedContaner properties
  double _heightSize = 0;
  double _widthSize = 0;
  double _radius = 100;

  //WidgetsLoginAndRegister
  Widget _loginWidget;

  // Key Identify Scaffold
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {

    // Start count for close the Splash animation for open Login Widget
    splashLoaded();

    // Defaulr
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: maincolor,
      body: Stack(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: FlareActor("assets/anims/_cloud_anim.flr", animation: "idle", fit: BoxFit.cover, color: Colors.white,)),
          Stack(
            children: <Widget>[
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isShowText ? 1 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                            height: 400,
                            child: FlareActor(
                              "assets/anims/_server_anim.flr",
                              animation: "Alarm",
                              fit: BoxFit.cover,
                              color: Colors.white,
                            )),
                        Container(
                            height: 400,
                            child: FlareActor(
                              "assets/anims/server_anim.flr",
                              animation: "idle",
                              fit: BoxFit.cover,
                            )),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        AnimatedOpacity(
                          opacity: isShowText ? 1 : 0,
                          duration: Duration(seconds: 1),
                          child: Text(
                            "Iniciando serviços...",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isShowText ? 1 : 0,
                          duration: Duration(seconds: 3),
                          child: Text(
                            "Coletando dados dos servidores...",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isShowText ? 1 : 0,
                          duration: Duration(seconds: 6),
                          child: Text(
                            "Gerenciando dados...",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  margin: EdgeInsets.all(20),
                  curve: Curves.easeIn,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(_radius), color: Colors.white),
                  height: _heightSize,
                  width: _widthSize,
                  duration: Duration(milliseconds: 250),
                  child: LoginWidget(_scaffoldKey, animateContainer), // Login Widget on folder lib/screens/login_screen/widgets/
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // function for show login animated container
  animateContainer() {
    setState(() {
      _heightSize = _heightSize == 0||_heightSize==70 ? 360 : 70;
      _widthSize = _widthSize == 0||_widthSize==70 ? MediaQuery.of(context).size.width : 70;
      _radius = _radius == 100 ? 5 : 100;
      isShowText = false;
    });
  }

  // Function show AnimatedOpacity
  void showText() async {
    await Future.delayed(Duration(seconds: 2));
    isShowText = true;
    setState(() {});
  }

  void splashLoaded() async {

    if(await Auth.isLogged()){
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
    }else{

      // Start animation of texts
      showText();
      await Future.delayed(Duration(seconds: 5));
      animateContainer();
    }
  }
}