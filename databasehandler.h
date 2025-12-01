#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <vector>
#include <QObject>
#include <QtQml>
#include <QUuid>
#include <QtSql>
#include "Secret.h"
#include "notificationObservers.h"

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

    WeakPasswordObserver _weakObserver;
    ExpirationObserver   _expirationObserver;

    void loadSavedData();

signals:
    void itemLoaded(QString, QString, int);
    void loadedWeb(int, QString, QString, QString);
    void loadCCSignal(int, QString, QString, QString, QString, QString);
    void loadIDSignal(int, QString, QString, QString, QString, QString);
    void loadNoteSignal(int, QString, QString);

    void weakPasswordFlagged(int idx);
    void expiryIssueFlagged(int idx);


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

    Q_INVOKABLE void updateField(int index, QString type, QString title, QString field, QString newData);
    Q_INVOKABLE void updateWebsite(int index, QString newURL, QString newUser, QString newPass);
    Q_INVOKABLE void updateCC(int index, QString name, QString ccNum, QString ccv, QString expiryDate, QString zipCode);
    Q_INVOKABLE void updateIDCard(int index, QString name, QString bday, QString gender, QString height, QString address);
    Q_INVOKABLE void updateNote(int index, QString name, QString text);

    Q_INVOKABLE bool isWeakPassword(QString pass) const;
    Q_INVOKABLE bool isExpired(QString exp) const;


    Q_INVOKABLE void loadWebsite(int index);
    Q_INVOKABLE void loadCC(int index);
    Q_INVOKABLE void loadID(int index);
    Q_INVOKABLE void loadNote(int index);

    Q_INVOKABLE void deleteItem(int index, QString type, QString titleField, QString title);

    void reportWeakPassword(ISecret* secret);
    void reportExpiryIssue(ISecret* secret);
};

#endif // DATABASEHANDLER_H
