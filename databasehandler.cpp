#include "databasehandler.h"

DatabaseHandler::DatabaseHandler() {}

void DatabaseHandler::initDatabase()
{
    if(isConnected == false)
    {
        qDebug() << "Available SQL drivers:" << QSqlDatabase::drivers();
        // Use the PostgreSQL driver

        db = QSqlDatabase::addDatabase("QODBC");

        // Build an ODBC connection string.
        QString connStr =
            "Driver={PostgreSQL ODBC Driver(UNICODE)};"
            "Server=shinkansen.proxy.rlwy.net;"
            "Port=17700;"
            "Database=railway;"
            "Uid=postgres;"
            "Pwd=AXKYvzjVxofQHczfQgVsxcSGWSjWtiZF;"
            "SSLmode=require;";

        db.setDatabaseName(connStr);

        if (!db.open()) {
            qWarning() << "ODBC connection failed:" << db.lastError().text();
        } else {
            qInfo() << "Connected to PostgreSQL on Railway via ODBC!";
            isConnected = true;
        }
    }
}

void DatabaseHandler::closeDatabase()
{
    if(isConnected == true)
    {
        db.close();
        isConnected = false;
    }
}

void DatabaseHandler::registerAccount(QString user, QString pass, QString q1, QString a1, QString q2, QString a2, QString q3, QString a3)
{
    QUuid uuid;
    QString idStr = uuid.createUuid().toString(QUuid::WithoutBraces);

    QSqlQuery query;
    query.prepare("INSERT INTO accounts (id, username, password, question1, answer1, question2, answer2, question3, answer3) "
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    query.bindValue(0, idStr);
    query.bindValue(1, user);
    query.bindValue(2, pass);
    query.bindValue(3, q1);
    query.bindValue(4, a1);
    query.bindValue(5, q2);
    query.bindValue(6, a2);
    query.bindValue(7, q3);
    query.bindValue(8, a3);
    query.exec();
}
