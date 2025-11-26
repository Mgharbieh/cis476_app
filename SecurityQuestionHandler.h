#ifndef SECURITYQUESTIONHANDLER_H
#define SECURITYQUESTIONHANDLER_H

#include <QString>

class SecurityQuestionHandler{
public:
    SecurityQuestionHandler* successor = nullptr;
    QString question;
    void setSuccessor(SecurityQuestionHandler*);
    bool handleRequest(QString question, QString Response);

    SecurityQuestionHandler(){

    };

    SecurityQuestionHandler(QString question, QString answer){
        this->question = question;
        this->answer = answer;
    }

private:
    QString answer;

};


#endif // SECURITYQUESTIONHANDLER_H
