import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: new PreferredSize(
        child: AppBar(
          backgroundColor: Colors.yellow,
          title: title,
          centerTitle: true,
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: body(context),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            FocusScope.of(context).unfocus();
          },
          child: Icon(
            Icons.search,
            color: Colors.white,
          )),
    );
  }
}

Widget title = RichText(
  text: TextSpan(
    text: ' Br ',
    style: TextStyle(
      fontStyle: FontStyle.italic,
      backgroundColor: Colors.green,
      fontWeight: FontWeight.w600,
      fontSize: 40.0,
      color: Colors.white,
    ),
    children: <TextSpan>[
      TextSpan(
        text: 'eaking',
        style: TextStyle(
          fontStyle: FontStyle.normal,
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.w700,
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      TextSpan(
        text: '  ',
        style: TextStyle(
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.w700,
          fontSize: 40.0,
          color: Colors.white,
        ),
      ),
      TextSpan(
        text: ' Ba ',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          backgroundColor: Colors.green,
          fontWeight: FontWeight.w600,
          fontSize: 40.0,
          color: Colors.white,
        ),
      ),
      TextSpan(
        text: "d",
        style: TextStyle(
          fontStyle: FontStyle.normal,
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.w600,
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
    ],
  ),
);

ListView body(context) {
  return ListView(
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
                hintText: "Find anything about Breaking Bad",
                fillColor: Colors.yellow,
              ),
            ),
          ),
        ],
      ),
      new GridView.count(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return Card(
            color: Colors.grey[300],
            child: GridTile(
              child: new InkWell(
                // splashColor: Colors.blue.withAlpha(30),
                child: Image.network(
                  "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
                  height: 250.0,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return detailView(context);
                  }));
                },
              ),
              footer: GridTileBar(
                leading: new Icon(Icons.verified_user),
                title: new Text("Walter White"),
                subtitle: new Text("Heisenberg"),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          );
        }),
      )
    ],
  );
}

SimpleDialog detailView(context) {
  return SimpleDialog(
    title: new Text("Walter White"),
    children: [
      new Container(
        child: Column(
          children: [
            new Container(
              child: new Column(
                children: [
                  new Text(
                    "Name : Walter White",
                  ),
                  new Text(
                    "Birthday : 09-07-1958",
                  ),
                  new Text(
                    "Occupation : High School Chemistry Teacher & Meth King Pin",
                  ),
                  new Text(
                    "Status : Presumed dead",
                  ),
                  new Text("Nickname : Heisenberg"),
                  new Text(
                    "Appearance : Season : 1,2,3,4,5",
                  ),
                  new Text(
                    "Portrayed : Bryan Cranston",
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: null),
            ),
          ],
        ),
      ),
    ],
  );
}
