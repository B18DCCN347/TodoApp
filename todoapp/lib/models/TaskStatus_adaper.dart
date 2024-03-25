import 'package:hive/hive.dart';
import 'package:todoapp/utils/constanst.dart';

class StatusTaskAdapter extends TypeAdapter<StatusTask> {
  @override
  final typeId = 102;

  @override
  void write(BinaryWriter writer, StatusTask obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name);
  }

  StatusTask read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return fields[0];
  }
}
