#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "login.h"
#include "passwordGenerator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Login loginObj;
    PassBuilder pwdGen;
    engine.rootContext()->setContextProperty("LOGIN", &loginObj);
    engine.rootContext()->setContextProperty("PASSBUILDER", &pwdGen);

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
