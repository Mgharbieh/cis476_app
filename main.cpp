#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QDebug>

#include "SessionManager.h"

int main(int argc, char *argv[])
{
  auto& session = SessionManager::getInstance(argc, argv);
   session.run();
   return session.app.exec();

}
