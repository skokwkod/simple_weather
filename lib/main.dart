import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Models/cities.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleWeather(title: 'Flutter Demo Home Page'),
    );
  }
}

class SimpleWeather extends StatefulWidget {
  const SimpleWeather({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SimpleWeather> createState() => _SimpleWeatherState();
}

class _SimpleWeatherState extends State<SimpleWeather> {
  List<Cities>? selectedCity;
 bool isReady = false;


  @override
  void initState() {
    super.initState();
     fillData('Lubin');
    print('initstate');

  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  fillData(String city) async {
    selectedCity = await Cities.fetchCities(city);
    setState(() {
      isReady = true;
    });

    print(selectedCity?[0].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: TextField(
                  obscureText: false,
                  textCapitalization: TextCapitalization.words,
                  controller: myController,
                  decoration: InputDecoration(hintText: 'Wpisz szukane miasto'),
                ),
              ),
            ),
            MaterialButton(
                onPressed: () {
                  setState(() {
                    fillData(myController.text);
                  });
                },
                child: Text("Sprawdź"),
                color: Colors.indigoAccent),
            if(isReady)
            Container(
              height: 600,
              child: ListView.builder(
                  itemCount: selectedCity!.length,
                  itemBuilder:  (BuildContext context, int i){
                    final city = selectedCity![i];
                    return
                        Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(city.id.toString()),
                                ),
                                Column(children: [
                                  Text(city.name,
                                  style: Theme.of(context).textTheme.headline4,),
                                  Text(city.state),
                                  Text(city.country),


                                ],),
                              ],
                            ),
                          ),
                        );
                  }
              ),
            ),
            // Text(
            //   name,
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            // //  Text(selectedCity[0].country != null ? "Brak":"tada",
            //
            //     style: Theme.of(context).textTheme.headline5,
            //   ),
          ],
        ),
      ),
    );
  }
}
