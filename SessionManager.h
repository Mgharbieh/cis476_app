#ifndef SESSIONMANAGER_H
#define SESSIONMANAGER_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QDebug>

#include "login.h"
#include "passwordGenerator.h"
#include "databasehandler.h"
#include "copyhandler.h"


class SessionManager {
public:
    static SessionManager& getInstance(int argc = 0, char *argv[] = nullptr) {
        static SessionManager instance(argc, argv);
        return instance;
    }

    void run(){
        QObject::connect(&loginObj, &Login::loginSignal, &data, &DatabaseHandler::userLogin);

        data.initDatabase();
        engine.rootContext()->setContextProperty("LOGIN", &loginObj);
        engine.rootContext()->setContextProperty("PASSBUILDER", &pwdGen);
        engine.rootContext()->setContextProperty("DATABASE", &data);
        engine.rootContext()->setContextProperty("CLIPBOARD", &copy);

        const QUrl url(QStringLiteral("qrc:/cis476_app/Main.qml"));
        QObject::connect(
            &engine,
            &QQmlApplicationEngine::objectCreationFailed,
            &app,
            []() { QCoreApplication::exit(-1); },
            Qt::QueuedConnection);
        engine.load(url);
    }

    // Delete copy & move semantics – this is a strict singleton
    SessionManager(const SessionManager&) = delete;
    SessionManager& operator=(const SessionManager&) = delete;
    SessionManager(SessionManager&&) = delete;
    SessionManager& operator=(SessionManager&&) = delete;

public:
    QGuiApplication app;
    QQmlApplicationEngine engine;
    Login loginObj;
    PassBuilder pwdGen;
    DatabaseHandler data;
    CopyHandler copy;
private:
    // Private constructor
    SessionManager(int argc, char *argv[])
        : app(argc, argv)
    {
    }
};

#endif // SESSIONMANAGER_H
