part of 'fetch_data_bloc.dart';

@immutable
abstract class FetchDataState {}

abstract class FetchActionDataState {}

class FetchDataInitial extends FetchDataState {}

class LoadingState extends FetchDataState {}

class DataSucessState extends FetchDataState {
  final List<DataModel> result;

  DataSucessState({required this.result});
}

class DataErrorState extends FetchDataState {}

class AddDataSucessState extends FetchDataState {}

class AddDataErrorState extends FetchDataState {}
