#include "SecurityQuestionHandler.h"

void SecurityQuestionHandler::setSuccessor(SecurityQuestionHandler* successor){
    this->successor = successor;
}

bool SecurityQuestionHandler::handleRequest(QString question, QString response){

    if(this->question == question){
        //is response correct?
        return (this->answer == response);
    }

    //wrong question. Is there a successor?
    if (successor)
        //return what successor finds.
        return successor->handleRequest(question, response);

    //question not found
    return false;
}
