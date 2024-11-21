import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('stop_smoking.db');
    return _database!;
  }

  // Inisialisasi database dan path
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Membuat tabel smoke_data di database
  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE smoke_data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      cigarettes_today INTEGER NOT NULL,
      cigarettes_yesterday INTEGER NOT NULL,
      total_cigarettes INTEGER NOT NULL,
      money_saved REAL NOT NULL
    )
    ''');
  }

  // Fungsi untuk menambahkan data ke tabel smoke_data (Create)
  Future<int> insertSmokeData(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('smoke_data', row);
  }

  // Fungsi untuk mengambil semua data dari tabel smoke_data (Read)
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await instance.database;
    return await db.query('smoke_data');
  }

  // Fungsi untuk memperbarui data pada tabel smoke_data berdasarkan id (Update)
  Future<int> updateSmokeData(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update('smoke_data', row, where: 'id = ?', whereArgs: [id]);
  }

  // Fungsi untuk menghapus data dari tabel smoke_data berdasarkan id (Delete)
  Future<int> deleteSmokeData(int id) async {
    final db = await instance.database;
    return await db.delete('smoke_data', where: 'id = ?', whereArgs: [id]);
  }

  // Fungsi untuk menutup koneksi database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
