import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartView extends StatefulWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _cityId = 0;

  Future<void> getSharedPref() async{
    final SharedPreferences prefs = await _prefs;

      _cityId =  (prefs.getInt('cityId') ?? 0);

    if(_cityId == 0)
      {
        print("nic do wyświetlenia");
      }
    print(_cityId);
  }

  Future<void> setSharedPref() async{
    final SharedPreferences prefs = await _prefs;

    await prefs.setInt('cityId', _cityId+10);
  }


  @override
  void initState() {
    print("initState getSharedPref");
    getSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("witaj"),
      ),
      body: Column(
        children: [
            MaterialButton(onPressed: () {
                setSharedPref();
                getSharedPref();
            },
            child: Text("Test"),),
        Text(_cityId.toString())
        ],
      ),
    );
  }
}
