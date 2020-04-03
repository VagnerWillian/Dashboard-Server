import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servidordashboard/constraints.dart';
import 'package:servidordashboard/local_data/preferences.dart';
import 'package:servidordashboard/repository/term.repository.dart';
import 'package:servidordashboard/screens/login_screen/splash.login.dart';
import 'package:servidordashboard/screens/main_screen/tiles/server_menu.tile.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  TermRepository _termRepository = TermRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                Container(
                    width: 60,
                    child: RaisedButton(
                        onPressed: () {
                          LocalData.clearLocalData();
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => SplashLoginScreen()));
                        },
                        color: maincolor,
                        elevation: 0,
                        child: Icon(Icons.exit_to_app, color: Colors.white,)))
              ],
              backgroundColor: maincolor,
              elevation: 0,
              centerTitle: true,
              title: Text("Servidores"),
              leading: RaisedButton(
                child: Icon(Icons.menu, color: Colors.white,),
                onPressed: () {},
                color: Colors.transparent,
                elevation: 0,
              ),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text('',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Container(
                    padding: EdgeInsets.all(50),
                    margin: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.warning, color: Colors.yellow[800],),
                          Text("Sevidores com instabilidade", style: TextStyle(color: Colors.yellow[800]),)
                        ],
                      ),
                    )
                  )
              ),
            ),

          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 80,
                child: Center(child: Text("Servidores")),
              ),
              FutureBuilder(
                future: _termRepository.fetchTerms(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),);
                  }else{
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(20),
                      height: 200,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 100.0, // has the effect of softening the shadow
                              spreadRadius: 2.0, // h// as the effect of extending the shadow
                            ),
                          ],
                          color: Colors.white
                      ),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: Html(
                            data: snapshot.data,
                            padding: EdgeInsets.all(8.0),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              ServerMenuTile(id: "#5468975", name: "SERVIDOR-APROFEM", rede: "APROF-PC", status: serverStatus.OK,),
              ServerMenuTile(id: "#6654287", name: "SERV-PC", rede: "REDE-PC", status: serverStatus.OK,),
              ServerMenuTile(id: "#9034898", name: "SERVER-ADVAUD", rede: "ADVAUD-PC", status: serverStatus.ERROR,),
              ServerMenuTile(id: "#7897545", name: "SERVER-CLIENTE", rede: "CLIENT-PC", status: serverStatus.WARNING,),
            ],
          ),
        ),
      ),
    );
  }
}