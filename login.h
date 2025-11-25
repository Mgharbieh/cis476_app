#ifndef LOGIN_H
#define LOGIN_H

#include <QObject>
#include <QtQml>

#include <QtSql>
#include <QDebug>

class Login : public QObject
{
    Q_OBJECT

private:
    inline static bool isLoggedIn = false;

signals:
    void logoutSignal();

public:
    Login() {};

    Q_INVOKABLE bool tryLogin(QString user, QString pass)
    {
        // Skip if logged in flag is true. Don't allow another login attempt pretty much
        if (isLoggedIn)
            return false;

        // Returns database connection from main.cpp
        QSqlDatabase db = QSqlDatabase::database();
        if (!db.isOpen()) {
            qWarning() << "DB not open, falling back to hardcoded login";
        } else {
            // Create query object
            QSqlQuery query;

            //Find a row where both the username and password matching
            query.prepare("SELECT id FROM accounts "
                          "WHERE username = ? AND password = ?");

            // Bind in order, user gets first "?", pass gets binded to second "?" above
            query.addBindValue(user);
            query.addBindValue(pass);

            // Show log if failed, return true if successed
            if (!query.exec()) {
                qWarning() << "Login query failed:" << query.lastError().text();
            } else if (query.next()) {

                // Found a matching row
                QString loginID = query.value(0).toString();

                isLoggedIn = true;
                return true;
            }
        }

        // hardcoded fallback
        if ((user == "Bob") && (pass == "Password")) {
            isLoggedIn = true;
            return true;
        }

        return false;
    }

    Q_INVOKABLE void logout() {
        emit logoutSignal();
        isLoggedIn = false;
    }

};

#endif // LOGIN_H
