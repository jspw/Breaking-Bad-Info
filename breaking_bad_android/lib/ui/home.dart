import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

import 'detail_view.dart';

final myController = TextEditingController();

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    // throw UnimplementedError();
    return HomeState();
  }
}

class HomeState extends State {
  final globalKey = GlobalKey<ScaffoldState>();
  List<Character> characters = [];

  Future<List<Character>> _getCharacters() async {
    var data = await http.get("https://breakingbadapi.com/api/characters");

    var jsondata = json.decode(data.body);

    // print(jsondata);

    for (var data in jsondata) {
      Character character = Character(
        data["name"],
        data["birthday"],
        data["occupation"],
        data["status"],
        data["nickname"],
        data["appearance"],
        data["portrayed"],
        data['img'],
      );

      this.characters.add(character);
      // print(character);
    }

    return characters;

    // for (var i in characters) print(i);
  }

  int Searching(String name) {
    for (int i = 0; i < characters.length; i++) {
      if (characters[i].name.toLowerCase() == name.toLowerCase()) {
        return i;
      } else if (characters[i].nickname.toLowerCase() == name.toLowerCase()) {
        return i;
      }
    }
    return 500;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.grey[300],
      appBar: new PreferredSize(
        child: AppBar(
          backgroundColor: Colors.yellow,
          title: title(),
          centerTitle: true,
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: ListView(
        children: [
          Container(
            child: Image.asset("assets/logo0.jpg"),
          ),
          Divider(),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(40.0),
                child: new TextField(
                  controller: myController,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    hintText: "Find A Character OF Breaking Bad",
                    fillColor: Colors.yellow,
                  ),
                ),
              ),
            ],
          ),
          new FutureBuilder(
            future: _getCharacters(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print("Snapshot.data  gets : ${snapshot.data}");
              if (snapshot.data == null) {
                // if (checkInternetConnection() == true) {
                return new Container(
                  alignment: Alignment.center,
                  child: new Text(
                    "Loading.....",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                    ),
                  ),
                );
                // }
                // else {
                //   final snackBar = SnackBar(
                //     content: Text(
                //       'No Internet Connection!',
                //       textAlign: TextAlign.center,
                //     ),
                //     backgroundColor: Colors.red,
                //     // duration: Duration(milliseconds: 1000)
                //   );
                //   globalKey.currentState.showSnackBar(snackBar);
                // }
              } else
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // crossAxisSpacing: 5.0,
                    // mainAxisSpacing: 5.0,
                  ),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Container(
                      margin: const EdgeInsets.all(7.0),
                      // padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(10),
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: GridTile(
                        child: new InkWell(
                          // splashColor: Colors.blue.withAlpha(30),
                          child: Image.network(
                            snapshot.data[index].img,
                            fit: BoxFit.fill,
                            // height: 200.0,
                            // width: 200.0,
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailView(
                                  snapshot.data[index].name,
                                  snapshot.data[index].birthday,
                                  snapshot.data[index].occupation,
                                  snapshot.data[index].status,
                                  snapshot.data[index].nickname,
                                  snapshot.data[index].appearance,
                                  snapshot.data[index].portrayed,
                                  snapshot.data[index].img);
                            }));
                          },
                        ),
                        footer: GridTileBar(
                          // leading: new Icon(Icons.verified_user),
                          title: new Text(
                            snapshot.data[index].name,
                          ),
                          subtitle: new Text(
                            snapshot.data[index].nickname,
                          ),
                        ),
                      ),
                    );
                  },
                );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          int index = Searching(myController.text);
          print("Index value :  $index");
          if (index == 500) {
            FocusScope.of(context).unfocus();

            final snackBar = SnackBar(
              content: Text(
                'No name Match!',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red,
              // duration: Duration(milliseconds: 1000)
            );
            globalKey.currentState.showSnackBar(snackBar);
            // return Scaffold.of(context).showSnackBar(snackBar);
          } else {
            FocusScope.of(context).unfocus();
            myController.clear();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailView(
                  characters[index].name,
                  characters[index].birthday,
                  characters[index].occupation,
                  characters[index].status,
                  characters[index].nickname,
                  characters[index].appearance,
                  characters[index].portrayed,
                  characters[index].img);
            }));
          }
        },
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}

RichText title() {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        titleTextSpan(" Br ", titleTextStyleMain()),
        titleTextSpan("eaking", titleTextStyleSub()),
        titleTextSpan("  ", titleTextStyleSub()),
        titleTextSpan(" Ba ", titleTextStyleMain()),
        titleTextSpan("d", titleTextStyleSub()),
      ],
    ),
  );
}

TextSpan titleTextSpan(text, style) {
  return new TextSpan(
    text: text,
    style: style,
  );
}

TextStyle titleTextStyleMain() {
  return new TextStyle(
    fontStyle: FontStyle.italic,
    backgroundColor: Colors.green,
    fontWeight: FontWeight.w600,
    fontSize: 40.0,
    color: Colors.white,
  );
}

TextStyle titleTextStyleSub() {
  return new TextStyle(
    fontStyle: FontStyle.normal,
    backgroundColor: Colors.yellow,
    fontWeight: FontWeight.w600,
    fontSize: 30.0,
    color: Colors.black,
  );
}

class Character {
  String name;
  String birthday;
  List occupation;
  String status;
  String nickname;
  List appearance;
  String portrayed;
  String img;
  Character(this.name, this.birthday, this.occupation, this.status,
      this.nickname, this.appearance, this.portrayed, this.img);
}
