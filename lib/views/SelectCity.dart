import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../Models/cities.dart';
import '../Models/weather.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SelectCity> createState() => _SimpleWeatherState();
}

class _SimpleWeatherState extends State<SelectCity> {
  List<Cities>? selectedCity;
  List<Weather>? selectedCityWeather;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    fillDataCity('Lubin');
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

  fillDataCity(String city) async {
    selectedCity = await Cities.fetchCities(city);
    setState(() {
      isReady = true;
    });

    print(selectedCity?[0].name);
  }

  fillDataCityWeather(num cityId) async {
    print("fillDataCityWeather cityId: "+cityId.toString());
    selectedCityWeather = await Weather.fetchWeather(cityId);
    setState(() {
      isReady = true;
    });

    print(selectedCityWeather?[0].mainWeather);
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
                    fillDataCity(myController.text);
                  });
                },
                child: Text("Sprawdź"),
                color: Colors.indigoAccent),
            if (isReady)
              Expanded(
                child: ListView.builder(
                    itemCount: selectedCity!.length,
                    itemBuilder: (BuildContext context, int i) {
                      final city = selectedCity![i];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print("id: " + selectedCity![i].id.toString());
                            fillDataCityWeather(selectedCity![i].id);
                          },
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(city.id.toString()),
                                  ),
                                  Column(
                                    children: [
                                      AutoSizeText(
                                        city.name,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(city.state),
                                      Text(city.country),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
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