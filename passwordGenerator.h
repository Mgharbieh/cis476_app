#ifndef PASSWORDGENERATOR_H
#define PASSWORDGENERATOR_H

#include <QObject>
#include <QtQml>
#include <QString>
#include <random>
#include <chrono>


// PASSWORD STORAGE OBJECT /////////////////////////////////////////////////
class Password : public QObject
{
    Q_OBJECT

private:
    QString password;

public:
    Password() {}
    QString getPassword() {return password;}
    void setPass(QString p) {password = p;}
};
////////////////////////////////////////////////////////////////////////////

// BUILDER INTERFACE ///////////////////////////////////////////////////////
class IBuilder : public QObject
{
public:
    virtual QString build(int len) = 0;
};
////////////////////////////////////////////////////////////////////////////

// BUILDER OBJECT //////////////////////////////////////////////////////////
class PassBuilder : public IBuilder
{
    Q_OBJECT
    QML_ELEMENT
private:
    Password pass;
    const QString charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()_+-=[]{}|;:,.<>?";

public:

    Q_INVOKABLE QString build(int len) override
    {
        std::default_random_engine generator(std::chrono::system_clock::now().time_since_epoch().count());
        std::uniform_int_distribution<int> distribution(0, charSet.length() - 1);

        QString generatedPass = "";
        for(int i = 0; i < len; i++)
        {
            generatedPass += charSet[distribution(generator)];
        }

        pass.setPass(generatedPass);
        return pass.getPassword();
    }
};
////////////////////////////////////////////////////////////////////////////

#endif // PASSWORDGENERATOR_H
