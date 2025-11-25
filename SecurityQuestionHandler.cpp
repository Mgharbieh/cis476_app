#include "SecurityQuestionHandler.h"

void SecurityQuestionHandler::setSuccessor(SecurityQuestionHandler successor){
    this->successor = &successor;
}

// bool SecurityQuestionHandler::handleRequest(QString response){
//     if(this->successor == nullptr){

//     }
// }
