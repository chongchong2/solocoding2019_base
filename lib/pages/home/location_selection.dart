import 'package:flutter/material.dart';
import 'package:solocoding2019_base/blocs/weather_bloc.dart';

class LocationSelection extends StatefulWidget {
  @override
  State<LocationSelection> createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색'),
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    hintText: 'Chicago',
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, _textController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}



//class LocationSelection extends StatelessWidget {
////  _weatherBloc.dispatch(FetchWeather(city: 'seoul'));
//  WeatherBloc weatherBloc;
//  final TextEditingController _textController = TextEditingController();
//
//  LocationSelection({
//    Key key,
//    @required this.weatherBloc,
//  })  : assert(weatherBloc != null),
//        super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Form(
//      child: Row(
//        children: [
//          Expanded(
//            child: Padding(
//              padding: EdgeInsets.only(left: 10.0),
//              child: TextFormField(
//                controller: _textController,
//                decoration: InputDecoration(
//                  labelText: 'City',
//                  hintText: 'Seoul',
//                ),
//                autofocus: false,
//              ),
//            ),
//          ),
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {
////              Navigator.pop(context, _textController.text);
//            _textController.text ??
//              weatherBloc.dispatch(FetchWeather(city: _textController.text));
//            },
//          )
//        ],
//      ),
//    );
//
//  }
//}