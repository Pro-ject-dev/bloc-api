part of 'fetch_data_bloc.dart';

@immutable
abstract class FetchDataEvent {}

class GetDataEvent extends FetchDataEvent {}

class AddDataEvent extends FetchDataEvent {}
