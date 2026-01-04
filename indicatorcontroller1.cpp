#include "indicatorcontroller1.h"

IndicatorController::IndicatorController(QObject *parent)
    : QObject(parent)
{

}

// setter with change gurard
void IndicatorController::setParkingBrakeOn(bool on){
    if (m_parkingBrakeOn == on) return;
    m_parkingBrakeOn = on;
    emit parkingBrakeOnChanged();
}

void IndicatorController::setLeftTurnSignalOn(bool on){
    if (m_leftTurnSignalOn == on) return;
    m_leftTurnSignalOn = on;
    emit leftTurnSignalOnChanged();
}

void IndicatorController::setRightTurnSignalOn(bool on){
    if(m_rightTurnSignalOn == on) return;
    m_rightTurnSignalOn = on;
    emit rightTurnSignalOnChanged();
}

void IndicatorController::setFuelWarningOn(bool on){
    if(m_fuelWarningOn == on) return;
    m_fuelWarningOn = on;
    emit fuelWarningOnChanged();
}

// slots: toggleParkingBrake
void IndicatorController::toggleParkingBrake(){
    setParkingBrakeOn(!m_parkingBrakeOn);
}

void IndicatorController::setTurnSignal(TurnDirection direction){
    switch (direction) {
    case TurnDirection::None:
        setLeftTurnSignalOn(false);
        setRightTurnSignalOn(false);
        break;
    case TurnDirection::Left:
        setLeftTurnSignalOn(true);
        setRightTurnSignalOn(false);
        break;

    case TurnDirection::Right:
        setRightTurnSignalOn(!m_rightTurnSignalOn);
        setLeftTurnSignalOn(false);
        break;
    }
}
