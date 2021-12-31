import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'detailpage.dart';
import 'room.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List _roomList = [];
  String textCenter = "Loading...";
  late double screenHeight, screenWidth;

  @override
  void initState() {
      super.initState();
      _loadRooms();
    }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child:  Column(children: [
         _roomList == null ?  const Flexible(
          child: Center(child: Text("No Data")),):
             Flexible(
               child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: (screenWidth / screenHeight),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20),
                    itemCount: _roomList.length,
                    itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                child: Container(
                child: Column(children:[
                      const SizedBox(height:10),
                      CachedNetworkImage(
                            height: 120,
                            width: 120,
                            imageUrl: "https://slumberjer.com/rentaroom/images/" + _roomList[index]["roomid"] + "_1.jpg",
                ),const SizedBox(height:10),
                      Text( _roomList[index]["title"] + "\n" + 
                            "Price(Month):" + "RM " + _roomList[index]["price"] + "\n" +
                            "Deposit: " + "RM " + _roomList[index]["deposit"] + "\n" + 
                            "Area: " + _roomList[index]["area"] + "\n",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ]),
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent[100],
                    borderRadius: BorderRadius.circular(15)),
                ),
                  onTap: () => {roomDetails(index)},
              );
            }),
             ),

               ))],
        ),
        ),
      );  
  }
  Future<void> _loadRooms() async {
    var url = Uri.parse("https://slumberjer.com/rentaroom/php/load_rooms.php");
    var response = await http.get(url);
    var rescode = response.statusCode;
    if(rescode == 200){
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      _roomList = parsedJson['data']['rooms'];
      textCenter = "Contain Data";
      setState(() {});
        print(_roomList);
      } else {
        textCenter = "No data";
        return;
      } 
  }
  roomDetails(int index) {
    Room room = Room(
        roomid: _roomList[index]["roomid"],
        contact: _roomList[index]["contact"],
        title: _roomList[index]["title"],
        description: _roomList[index]["description"],
        price: _roomList[index]["price"],
        deposit: _roomList[index]["deposit"],
        state: _roomList[index]["state"],
        area: _roomList[index]["area"],
        date_created: _roomList[index]["date_created"],
        latitude: _roomList[index]["latitude"],
        longitude: _roomList[index]["longitude"]);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailPage(
                  room: room,
                )));
  }
}
