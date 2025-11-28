#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QDebug>

#include "login.h"
#include "passwordGenerator.h"
#include "databasehandler.h"
#include "SessionManager.h"

int main(int argc, char *argv[])
{
  // auto& session = SessionManager::getInstance(argc, argv);
   // session.run();
   // return session.app.exec();
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Login loginObj;
    PassBuilder pwdGen;
    DatabaseHandler data;

    QObject::connect(&loginObj, &Login::loginSignal, &data, &DatabaseHandler::userLogin);

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
