#ifndef INDICATORCONTROLLER1_H
#define INDICATORCONTROLLER1_H

#include <QQmlEngine>
#include <QObject>
#include <qqmlintegration.h>

class IndicatorController : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON 

    // Q_PROPERTY for indicator states
    Q_PROPERTY(bool parkingBrakeOn READ parkingBrakeOn WRITE setParkingBrakeOn NOTIFY parkingBrakeOnChanged FINAL)
    Q_PROPERTY(bool leftTurnSignalOn READ leftTurnSignalOn WRITE setLeftTurnSignalOn NOTIFY leftTurnSignalOnChanged FINAL)
    Q_PROPERTY(bool rightTurnSignalOn READ rightTurnSignalOn WRITE setRightTurnSignalOn NOTIFY rightTurnSignalOnChanged FINAL)
    Q_PROPERTY(bool fuelWarningOn READ fuelWarningOn WRITE setFuelWarningOn NOTIFY fuelWarningOnChanged FINAL)
public:

    enum class TurnDirection {
        None,
        Left,
        Right
    };
    Q_ENUM(TurnDirection)

    explicit IndicatorController(QObject *parent = nullptr);

    // getters
    bool parkingBrakeOn() const {return m_parkingBrakeOn;}
    bool leftTurnSignalOn() const {return m_leftTurnSignalOn;}
    bool rightTurnSignalOn() const {return m_rightTurnSignalOn;}
    bool fuelWarningOn() const {return m_fuelWarningOn;}

    // setters
    void setParkingBrakeOn(bool on);
    void setLeftTurnSignalOn(bool on);
    void setRightTurnSignalOn(bool on);
    void setFuelWarningOn(bool on);

public slots: 
    void toggleParkingBrake();
    void setTurnSignal(TurnDirection direction);

signals:
    void parkingBrakeOnChanged();
    void leftTurnSignalOnChanged();
    void rightTurnSignalOnChanged();
    void fuelWarningOnChanged();
    void warningTriggered(const QString &message);

private:
    bool m_parkingBrakeOn = true;
    bool m_leftTurnSignalOn = false;
    bool m_rightTurnSignalOn = false;
    bool m_fuelWarningOn = false;

};


#endif // INDICATORCONTROLLER1_H
