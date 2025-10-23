#ifndef LOGIN_H
#define LOGIN_H

#include <QObject>
#include <QtQml>

class Login : public QObject
{
    Q_OBJECT

private:
    inline static bool isLoggedIn = false;

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
};

#endif // LOGIN_H
