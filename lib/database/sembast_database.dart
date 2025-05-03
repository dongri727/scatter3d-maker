import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class SembastDatabase {
  static final SembastDatabase _singleton = SembastDatabase._();
  static Database? _database;

  SembastDatabase._();

  factory SembastDatabase() => _singleton;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDir.path, 'scatter3d.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    return database;
  }
}