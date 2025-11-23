#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <QObject>
#include <QtQml>
#include <QUuid>
#include <QtSql>

class DatabaseHandler : public QObject
{
    Q_OBJECT
private:
    inline static bool isConnected = false;
    inline static QSqlDatabase db;
public:
    DatabaseHandler();
    void initDatabase();
    void closeDatabase();

    Q_INVOKABLE void registerAccount(QString user, QString pass, QString q1, QString a1, QString q2, QString a2, QString q3, QString a3);

signals:
};

#endif // DATABASEHANDLER_H
