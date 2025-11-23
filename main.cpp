#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QDebug>

#include "login.h"
#include "passwordGenerator.h"
#include "databasehandler.h"

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
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Login loginObj;
    PassBuilder pwdGen;
    DatabaseHandler data;
    data.initDatabase();


    engine.rootContext()->setContextProperty("LOGIN", &loginObj);
    engine.rootContext()->setContextProperty("PASSBUILDER", &pwdGen);
    engine.rootContext()->setContextProperty("DATABASE", &data);

    const QUrl url(QStringLiteral("qrc:/cis476_app/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
