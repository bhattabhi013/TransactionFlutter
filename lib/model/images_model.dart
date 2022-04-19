import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'images_model.g.dart';

@HiveType(typeId: 1, adapterName: 'ImageAdapter')
class Images {
  @HiveField(0)
  late String path;
}
