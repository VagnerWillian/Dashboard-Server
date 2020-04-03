import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servidordashboard/constraints.dart';

enum serverStatus{
  OK, ERROR, WARNING
}

class ServerMenuTile extends StatelessWidget {

  String id;
  String name;
  String rede;
  var status;

  ServerMenuTile({this.id, this.name, this.rede, this.status});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: getStatus['color'],
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Text(id, style: TextStyle(color: Colors.white, fontSize: 12),)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 1),
                child: getStatus['icon'],
              )
            ],
          ),
          SizedBox(height: 10,),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Nome: ", style: TextStyle(color: Colors.grey),),
                  Text(name, style: TextStyle(color: maincolor, fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Rede: ", style: TextStyle(color: Colors.grey),),
                  Text(rede, style: TextStyle(color: maincolor, fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Status: ", style: TextStyle(color: Colors.grey),),
                  Text(getStatus['name'], style: TextStyle(color: maincolor, fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Map<String, dynamic> get getStatus{
    if(status == serverStatus.OK){
      return {"name": "OK", "icon": Icon(Icons.check_circle, color: Colors.greenAccent,), "color" : Colors.greenAccent};
    }else if(status == serverStatus.ERROR){
      return {"name": "ERROR", "icon": Icon(Icons.error, color: Colors.redAccent,), "color" : Colors.redAccent};
    }else if(status == serverStatus.WARNING){
      return {"name": "WARNING", "icon": Icon(Icons.warning, color: Colors.yellow[800],), "color" : Colors.yellow[800]};
    }
  }
}