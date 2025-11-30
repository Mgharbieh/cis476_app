#ifndef LOGIN_H
#define LOGIN_H

#include <QObject>
#include <QtQml>
#include "SecurityQuestionHandler.h"
#include <QtSql>
#include <QDebug>
#include <vector>
#include "Account.h"

class Login : public QObject
{
    Q_OBJECT

private:
    inline static bool isLoggedIn = false;
    Account* account = nullptr;

    int questionIndex = 0;

signals:
    void logoutSignal();
    void accountChanged();
    void loginSignal(QString userID, QString userName);

public:

    std::vector<QString> questions;

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
                emit loginSignal(loginID, user);
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

    Q_INVOKABLE bool accountExists(QString username){
        QSqlDatabase db = QSqlDatabase::database();
        if (!db.isOpen()) {
            qWarning() << "DB not open in trySecurityQuestions";
            return false;
        }

        QSqlQuery query;

        query.prepare(
            "SELECT password, question1, answer1, question2, answer2, question3, answer3 "
            "FROM accounts "
            "WHERE username = ?"
            );
        query.addBindValue(username);

        if (!query.exec()) {
            qWarning() << "Security questions query failed:"
                       << query.lastError().text();
            return false;
        }

        if (!query.next()) {
            // Username not found
            qDebug() << "No matching username:" << username;
            return false;
        }

        QString password = query.value(0).toString();
        QString q1= query.value(1).toString();
        QString a1= query.value(2).toString();
        QString q2= query.value(3).toString();
        QString a2= query.value(4).toString();
        QString q3= query.value(5).toString();
        QString a3= query.value(6).toString();

        // Delete previous account if any

        account = new Account(username, password, q1, a1, q2, a2, q3, a3);
        questions = account->questions;
        return true;
    }

    Q_INVOKABLE int submitResponse(QString question, QString response){
        if(questionIndex >= 3) questionIndex = 0;
        bool result = account->handler->handleRequest(question, response);
        if(result){
            questionIndex++;
        }
        return questionIndex;
    }

    Q_INVOKABLE QString getQuestion(int index) {
        if (account == nullptr) return "invalid account";
        if (account && index < account->questions.size())
            return account->questions[index];
        return "";
    }

    Q_INVOKABLE QString getPassword(){
        return account->getPassword();
    }
};

#endif // LOGIN_H
