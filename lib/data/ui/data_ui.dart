import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_blocapi/data/bloc/fetch_data_bloc.dart';

class DataUi extends StatefulWidget {
  const DataUi({super.key});

  @override
  State<DataUi> createState() => _DataUiState();
}

class _DataUiState extends State<DataUi> {
  @override
  void initState() {
    bloc.add(GetDataEvent());
    super.initState();
  }

  final bloc = FetchDataBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bloc.add(AddDataEvent());
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(title: Text("Api Integration with Bloc")),
        body: BlocConsumer<FetchDataBloc, FetchDataState>(
          bloc: bloc,
          listenWhen: (previous, current) => current is FetchActionDataState,
          buildWhen: (previous, current) => current is! FetchActionDataState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingState:
                return Center(child: CircularProgressIndicator());
              case DataSucessState:
                var states = state as DataSucessState;
                return ListView.builder(
                    itemCount: states.result.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.grey.shade400,
                            child: Column(
                              children: [
                                Text(
                                  states.result[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  states.result[index].body,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
              case AddDataSucessState:
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Data Stored Successfully !"),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                        onPressed: () {
                          bloc.add(GetDataEvent());
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue)
                  ],
                ));
              case AddDataErrorState:
                return Center(child: Text("Data Stored Failed !"));
              default:
                return Container();
            }
          },
        ));
  }
}
