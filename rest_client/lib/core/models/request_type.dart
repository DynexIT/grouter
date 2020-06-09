import 'package:hive/hive.dart';

part 'request_type.g.dart';

@HiveType(typeId: 3)
class RequestType{
  @HiveField(0)
  String currentRequestType;
  @HiveField(1)
  List<String> requestTypes;

  RequestType({this.currentRequestType, this.requestTypes});
}