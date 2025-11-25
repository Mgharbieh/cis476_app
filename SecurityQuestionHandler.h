#ifndef SECURITYQUESTIONHANDLER_H
#define SECURITYQUESTIONHANDLER_H

#include <QString>

class SecurityQuestionHandler{
public:
    SecurityQuestionHandler* successor = nullptr;
    QString question;
    void setSuccessor(SecurityQuestionHandler);
    bool handleRequest();

private:
    QString answer;

};

#endif // SECURITYQUESTIONHANDLER_H
