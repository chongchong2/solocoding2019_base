import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solocoding2019_base/blocs/file_bloc.dart';

class WeatherHistoryPage extends StatefulWidget {
  final FileBloc fileBloc;

  WeatherHistoryPage({
    Key key,
    @required this.fileBloc,
  })  : assert(fileBloc != null),
        super(key: key);

  @override
  State<WeatherHistoryPage> createState() => _WeatherHistoryPageState();
}

class _WeatherHistoryPageState extends State<WeatherHistoryPage> {
  final TextEditingController _textController = TextEditingController();
  FileBloc _fileBloc;

  @override
  void initState() {
    super.initState();
    _fileBloc = widget.fileBloc;
    _fileBloc.dispatch(LoadWeathers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('History'),
        ),
        body: Center(
            child: BlocBuilder(
                bloc: _fileBloc,
                builder: (_, FileState state) {
                  if (state is WeathersLoaded) {
                    print(state.weathers);
                    return Container(

                      child: ListView.builder(
                        itemCount: state.weathers.length,
                        itemBuilder: (context, position) {
                          return Card(
                              child: Padding(
                               padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      Text(
                                          state.weathers[position].date,
                                          style: TextStyle(fontSize: 13.0)
                                      ),

                                      Text(
                                          state.weathers[position].location,
                                          style: TextStyle(fontSize: 15.0)
                                      ),
                                      Text(
                                          state.weathers[position].current_temp + '°',
                                          style: TextStyle(fontSize: 15.0)
                                      ),
                                      Text(
                                          state.weathers[position].max_temp + '°' + '/' + state.weathers[position].min_temp + '°',
                                          style: TextStyle(fontSize: 10.0)
                                      ),
                                    ],
                                  ),


                              ),

                          );
                        },
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
  //                          LocationSelection(weatherBloc: _weatherBloc),
//                          Padding(
//                            padding: EdgeInsets.only(top: 70),
//                            child: Center(
//                              child: Text(
//                                '',
//                                style: TextStyle(
//                                  fontSize: 20,
//                                  fontWeight: FontWeight.w200,
//                                  color: Colors.white,
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
                    ));
                  }
                }
                )
        )
    );
  }
}
