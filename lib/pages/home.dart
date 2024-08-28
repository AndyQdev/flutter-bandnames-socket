import 'dart:io';

import 'package:bandnameapp/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Heroes del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(  
      appBar: AppBar(
        title: const Text('BandNames', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) { 
          return _bandTile(bands[index]);
        },
     ),
     floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      elevation: 1,
      onPressed: addNewBand
    ),
   );
  }
  Dismissible _bandTile (Band band){
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle( color: Colors.white),),
        ),
      ),
      onDismissed: (direction) => {
        print('direccion: $direction'),
        print('id: ${band.id}')
        // TODO: llamar el borrado en el server
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text( band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
        onTap: (){
          print(band.name);
        },
      ),
    );
  }
  addNewBand(){
    final textEditingController= TextEditingController();

    if (Platform.isAndroid){
      return showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: Text('New Band Name'),
            content: TextField(
              controller: textEditingController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: ()=>addBandToList(textEditingController.text)
              )
            ],
          );
        }
      );
    }
    showCupertinoDialog(
      context: context, 
      builder: (context){
        return CupertinoAlertDialog(
          title: const Text('New band name'),
          content: CupertinoTextField(
            controller: textEditingController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Agregar'),
              onPressed: ()=>addBandToList(textEditingController.text),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Cancelar'),
              onPressed: ()=> Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  void addBandToList(String name){
    
    print(name);
    if(name.length > 1){
      bands.add( Band(id: DateTime.now().toString(), name: name, votes: 0 ));
      setState(() {
        
      });
    }
    Navigator.pop(context);
  }
}

