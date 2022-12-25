const dbName = "notes.db";
const noteTable = "note";
const userTable = "user";
const idColumn = 'id';
const emailColumn = 'email';
const textColumn = 'text';
const userIdColumn = 'user_id';
const syncedColumn = 'is_synced_with_cloud';
const createNoteTable = '''CREATE TABLE IF NOT EXISTS 'note'(
        'id' INTEGER NOT NULL,
        'user_id' INTEGER NOT NULL,
        'text' TEXT,
        'is_synced_with_cloud' INTEGER DEFAULT 0,
        FOREIGN KEY('user_id') REFERENCES 'user'('id'),
        PRIMARY KEY('id' AUTOINCREMENT) 
      )''';

const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
        "id" INTEGER NOT NULL,
        "email" TEXT NOT NULL UNIQUE,
        PRIMARY KEY ("id" AUTOINCREMENT)
      );''';