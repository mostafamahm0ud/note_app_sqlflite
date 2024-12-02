import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDB();
    } else {
      return _db!;
    }
    return null;
  }

  initializeDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'note.db');
    Database myDb = await openDatabase(path,
        onCreate: _createDb, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  deleteMyDataBase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'note.db');
    await deleteDatabase(path);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("ALTER TABLE notes ADD COLUMN note TEXT");
    print("Table updated==============");
  }

  _createDb(Database db, int version) async {
    // هنا بستخدم الباتش عشان اقدر انفذ كذا جدول في قاعدة البيانات
    Batch batch = db.batch();
    batch.execute('''
        CREATE TABLE "notes" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "title" TEXT,
        "description" TEXT
        )''');
    batch.execute('''
        CREATE TABLE "batch-note" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "title" TEXT,
        "description" TEXT
        )''');
    await batch.commit();
    print("Table created==============");
  }

  readData(sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  updateData(sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  insertData(sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  delateData(sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

// easy to use with no sql raw query
  read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  update(String table, Map<String, Object?> values, String? where) async {
    Database? myDb = await db;
    int response = await myDb!.update(table, values, where: where);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

  delate(String table, String? where) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table, where: where);
    return response;
  }
}
