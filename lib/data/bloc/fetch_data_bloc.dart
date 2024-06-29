import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_blocapi/data/model/datamodel.dart';
import 'package:task_blocapi/data/repos/DataRepos.dart';

part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  FetchDataBloc() : super(FetchDataInitial()) {
    on<GetDataEvent>(getDataEvent);
    on<AddDataEvent>(addDataEvent);
  }

  FutureOr<void> getDataEvent(
      GetDataEvent event, Emitter<FetchDataState> emit) async {
    emit(LoadingState());
    List<DataModel> result = await DataRepos.fetchData();
    print(result);
    emit(DataSucessState(result: result));
  }

  Future<FutureOr<void>> addDataEvent(
      AddDataEvent event, Emitter<FetchDataState> emit) async {
    emit(LoadingState());
    bool status = await DataRepos.AddData();
    if (status) {
      emit(AddDataSucessState());
    } else {
      emit(AddDataErrorState());
    }
  }
}
