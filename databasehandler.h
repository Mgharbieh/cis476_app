#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <vector>
#include <QObject>
#include <QtQml>
#include <QUuid>
#include <QtSql>
#include "Secret.h"

class DatabaseHandler : public QObject
{
    Q_OBJECT
private:
    inline static bool isConnected = false;
    inline static QSqlDatabase db;
    QString user_ID;
    QString user_name;
    std::vector<ISecret*> vault;

    Website* webPointer;
    // ADD OTHER TYPE POINTERS HERE

    void loadSavedData();

signals:
    void itemLoaded(QString type, QString title, int idx);
    void websiteLoaded(QString URL, QString User, QString Pass);

public slots:
    void userLogin(QString uuid, QString name);

public:
    DatabaseHandler();
    void initDatabase();
    void closeDatabase();

    Q_INVOKABLE void registerAccount(QString user, QString pass, QString q1, QString a1, QString q2, QString a2, QString q3, QString a3);
    Q_INVOKABLE void saveWebsite(QString url, QString user, QString pass);
    Q_INVOKABLE void saveCC(QString name, QString ccNum, QString ccv, QString expiryDate, QString zipCode);
    Q_INVOKABLE void saveIDCard(QString name, QString bday, QString gender, QString height, QString address);
    Q_INVOKABLE void saveNote(QString name, QString text);

    Q_INVOKABLE void loadWebsite(int index);
};

#endif // DATABASEHANDLER_H
