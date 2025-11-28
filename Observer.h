#ifndef OBSERVER_H
#define OBSERVER_H

// Forward declaration
class ISecret;

class IObserver{
    public:
    virtual ~IObserver() = default;
    virtual void update(ISecret* subject) = 0;
};

#endif // OBSERVER_H
