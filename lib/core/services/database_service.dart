import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// =======================================================
///        DATABASE SERVICE (SQLite - SmartStock)
/// =======================================================
/// Cette classe gère toute la base de données locale
/// de l'application de gestion de stock.
///
/// Elle permet de :
/// - Gérer les produits (Inventaire)
/// - Gérer les fournisseurs
/// - Gérer les catégories
/// - Stocker l'historique des activités (Traçabilité)
///
/// Avantage : L'application fonctionne 100% OFFLINE.
/// =======================================================
class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('smartstock.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    
    // ---------- TABLE PRODUITS ----------
    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        sku TEXT UNIQUE,
        categoryId TEXT,
        supplierId TEXT,
        description TEXT,
        purchasePrice REAL,
        sellingPrice REAL,
        currentStock INTEGER,
        minStockLevel INTEGER,
        unit TEXT,
        imageUrl TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // ---------- TABLE FOURNISSEURS ----------
    await db.execute('''
      CREATE TABLE suppliers (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT,
        phone TEXT,
        address TEXT,
        contactPerson TEXT,
        notes TEXT,
        createdAt TEXT
      )
    ''');

    // ---------- TABLE CATÉGORIES ----------
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        icon TEXT
      )
    ''');

    // ---------- TABLE ACTIVITÉS (Audit Log) ----------
    await db.execute('''
      CREATE TABLE activities (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        type TEXT,
        userId TEXT,
        userName TEXT,
        timestamp TEXT
      )
    ''');
  }

  // ======================================================
  // Méthodes utilitaires (Génériques)
  // ======================================================

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> update(String table, String id, Map<String, dynamic> row) async {
    final db = await database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, String id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('products');
    await db.delete('suppliers');
    await db.delete('categories');
    await db.delete('activities');
  }
}
