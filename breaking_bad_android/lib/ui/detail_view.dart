import 'package:flutter/material.dart';
import 'home.dart';

class DetailView extends StatelessWidget {
  String name;
  String birthday;
  List occupation;
  String status;
  String nickname;
  List appearance;
  String portrayed;
  String img;
  DetailView(this.name, this.birthday, this.occupation, this.status,
      this.nickname, this.appearance, this.portrayed, this.img);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      appBar: new PreferredSize(
        child: AppBar(
          backgroundColor: Colors.yellow,
          title: title(),
          centerTitle: true,
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: ListView(padding: const EdgeInsets.all(20.0), children: [
        new Container(
          child: Column(
            children: [
              Container(
                child: Image.network(img),
              ),
              Divider(),
              new Center(
                child: new Column(
                  children: [
                    new Text(
                      "Name : ${this.name}",
                      style: style(),
                    ),
                    new Text(
                      "Occupation : ${occupation.join(" | ")}",
                      style: style(),
                    ),
                    new Text(
                      "Nickname : ${this.nickname}",
                      style: style(),
                    ),
                    new Text(
                      "Appearance In Season : ${appearance.join(", ")}",
                      style: style(),
                    ),
                    new Text(
                      "Portrayed : ${this.portrayed}",
                      style: style(),
                    ),
                    new Text(
                      "Status : ${this.status}",
                      style: style(),
                    ),
                    new Text(
                      "Birthday : ${this.birthday}",
                      style: style(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

TextStyle style() {
  return TextStyle(
    fontSize: 20.0,
  );
}
