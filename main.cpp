#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtSql>
#include <QDebug>

#include "login.h"
#include "passwordGenerator.h"
#include "databasehandler.h"
#include "copyhandler.h"
#include "SessionManager.h"

int main(int argc, char *argv[])
{
  auto& session = SessionManager::getInstance(argc, argv);
   session.run();
   return session.app.exec();

}
