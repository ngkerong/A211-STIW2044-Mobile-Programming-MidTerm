import 'package:flutter/material.dart';
import 'room.dart';
import 'package:cached_network_image/cached_network_image.dart';


class DetailPage extends StatefulWidget {
  final Room room;
  const DetailPage({Key? key, required this.room}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late double screenHeight, screenWidth;
  late List date = widget.room.date_created.toString().split(' ');

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room.title.toString(),
        style: const TextStyle (fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
    ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget>[
            Container(
              height:250,
              color: Colors.lightBlue,
            child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              CachedNetworkImage(
                height: 300,
                width: 300,
                imageUrl: "https://slumberjer.com/rentaroom/images/" + widget.room.roomid.toString() + "_1.jpg"),
              CachedNetworkImage(
                height: 300,
                width: 300,
                imageUrl: "https://slumberjer.com/rentaroom/images/" + widget.room.roomid.toString() + "_2.jpg"),
              CachedNetworkImage(
                height: 300,
                width: 300,
                imageUrl: "https://slumberjer.com/rentaroom/images/" + widget.room.roomid.toString() + "_3.jpg"),
            ]
      )),const SizedBox(height:20),
          Row( 
          children:[
               const SizedBox(width:30),
               Container(
                  color:Colors.lightBlue[200],
                  alignment: Alignment.center,
                  child: const Text(
                    "Room ID" + "\n" + 
                    "Contact" + "\n" +
                    "Price" +  "\n" +
                    "Deposit" +  "\n" +
                    "State" +  "\n" +
                    "Area"  + "\n" +
                    "Date Created "  + "\n" +
                    "Latitude"  + "\n" +
                    "Longitude",
                    style: TextStyle (fontSize: 15,fontWeight: FontWeight.bold ),
                  ),
        ),const SizedBox(width:15),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                     widget.room.roomid.toString() + "\n" + 
                     widget.room.contact.toString() + "\n" +
                     "RM " + widget.room.price.toString() + "\n" +
                     "RM " + widget.room.deposit.toString() + "\n" +
                     widget.room.state.toString() + "\n" +
                     widget.room.area.toString() + "\n" +
                     date[0] + "\n" +
                     widget.room.latitude.toString() + "\n" +
                     widget.room.longitude.toString(),
                     style: const TextStyle (fontSize: 15),
                  ),
          )]),const SizedBox(height:5),
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.grey[400],
                width: screenWidth,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description\n\n" + widget.room.description.toString(),
                   style: const TextStyle (fontSize: 15 )),
                  
                )
          ]),),
        );
  }
}