import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> setupHiveForTesting() async {
  final directory = await getTemporaryDirectory();
  Hive.init(directory.path);
}

Future<void> closeHiveForTesting() async {
  await Hive.close();
}

