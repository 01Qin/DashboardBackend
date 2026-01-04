#include "vehicledata1.h"
#include <qqmlintegration.h>
#include <QDebug>

VehicleData::VehicleData(QObject *parent)
    : QObject(parent)
{

}

// exercise 1 setter: speed
void VehicleData::setSpeed(int newSpeed)
{
    if (m_speed == newSpeed)
        return;  // Guard prevents unnecessary signal emission

    bool oldOverSpeeding = isOverSpeeding();
    m_speed = newSpeed;
    emit speedChanged();

    // exercise 4
    emit displaySpeedChanged();

    if (oldOverSpeeding != isOverSpeeding()){
        emit isOverSpeedingChanged();
    }
}

// exercise 1 setter: rpm
void VehicleData::setRpm(int newRpm)
{
    if (m_rpm == newRpm)
        return;

    // update member variable
    m_rpm = newRpm;
    emit rpmChanged();
}

// exercise 4 computed getter
int VehicleData::displaySpeed() const {

    if (m_speedUnit == SpeedUnit::MilePerHour){
        return static_cast<int>(m_speed * 0.621371);
    }
    return m_speed;
}

// Exercise 4 setter: speedUnit
void VehicleData::setSpeedUnit(SpeedUnit unit){
    if (m_speedUnit == unit)
        return;

    m_speedUnit = unit;
    emit speedUnitChanged();
    emit displaySpeedChanged();
}

// exercise 4 slot
void VehicleData::consumeFuel(double amount){
    double oldFuelLevel = m_fuelLevel;

    if (m_fuelLevel > 0){
        m_fuelLevel -= amount;
        if (m_fuelLevel < 0) m_fuelLevel = 0;
        if (oldFuelLevel != m_fuelLevel) {
        emit fuelLevelChanged();
        }
    }
}

// exercise 4: reset method
void VehicleData::resetAll(){
    setSpeed(0);
    setRpm(0);

    if (m_fuelLevel != 100.0){
        m_fuelLevel = 100.0;
        emit fuelLevelChanged();
    }

}
