#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QDebug>

#include "login.h"
#include "passwordGenerator.h"
#include "databasehandler.h"
#include "SessionManager.h"

static void initDatabase()
{


    qDebug() << "Available SQL drivers:" << QSqlDatabase::drivers();
    // Use the PostgreSQL driver
    QSqlDatabase db = QSqlDatabase::addDatabase("QODBC");

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
    }
}


int main(int argc, char *argv[])
{
    auto& session = SessionManager::getInstance(argc, argv);
    session.run();
    return session.app.exec();
}
