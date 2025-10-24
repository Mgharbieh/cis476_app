#ifndef LOGIN_H
#define LOGIN_H

#include <QObject>
#include <QtQml>

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
        if(isLoggedIn == false)
        {
            if((user == "Bob") && (pass == "Password"))
            {
                isLoggedIn = true;
                return true;
            }
            else
                return false;
        }
        else
            return false;
    }

    Q_INVOKABLE void logout() {
        emit logoutSignal();
        isLoggedIn = false;
    }

};

#endif // LOGIN_H
