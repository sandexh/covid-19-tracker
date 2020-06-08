import 'package:infocorona/pages/countyPage.dart';
import 'pages/countyPage.dart';
import 'api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future<WorldData> futureWorldData;
  Future<NepalData> futureNepalData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureWorldData = getWorldData();
    futureNepalData = getNepalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Covid-19 Updates'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'In Nepal',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder<NepalData>(
                  future: futureNepalData,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                cardWidget(
                                    title: 'Total',
                                    amount: snap.data.total_positive.toString(),
                                    color: Colors.red.shade300),
                                cardWidget(
                                    title: 'Deaths',
                                    amount: snap.data.deaths.toString(),
                                    color: Colors.red),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                cardWidget(
                                    title: 'Recovered',
                                    amount: snap.data.recovered.toString(),
                                    color: Colors.green.shade200),
                                cardWidget(
                                    title: 'Active',
                                    amount: (snap.data.total_positive -
                                            snap.data.recovered -
                                            snap.data.deaths)
                                        .toString(),
                                    color: Colors.blue.shade200),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'World Data',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder<WorldData>(
                  future: futureWorldData,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                cardWidget(
                                    title: 'Total',
                                    amount: snap.data.total.toString(),
                                    color: Colors.red.shade300),
                                cardWidget(
                                    title: 'Deaths',
                                    amount: snap.data.deaths.toString(),
                                    color: Colors.red),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                cardWidget(
                                    title: 'Recovered',
                                    amount: snap.data.recovered.toString(),
                                    color: Colors.green.shade200),
                                cardWidget(
                                    title: 'Active',
                                    amount: (snap.data.total -
                                            snap.data.recovered -
                                            snap.data.deaths)
                                        .toString(),
                                    color: Colors.blue.shade200),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    child: Text(
                      'Show All Countries Data',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.teal,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image(image: AssetImage('images/flag.png'), height: 70,width: 70,),
                Text(
                  '''
Follow Rules!
Stay Home! Stay Safe!                
                
                ''',
                  style: TextStyle(color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget cardWidget({color, title, amount}) {
  return Expanded(
    child: Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              amount,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}
