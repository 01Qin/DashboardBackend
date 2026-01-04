#include "vehiclesimulator1.h"
#include <QRandomGenerator>



VehicleSimulator::VehicleSimulator(QObject *parent)
    : QObject(parent)
    , m_updateTimer(new QTimer(this))

{   m_updateTimer->setInterval(10); // 10ms interval for smooth simulation
    connect(m_updateTimer, &QTimer::timeout,
            this, &VehicleSimulator::updateVehicle);

}

void VehicleSimulator::setVehicleData(VehicleData *data){
    if (m_vehicleData == data)
        return;
    m_vehicleData = data;
    emit vehicleDataChanged();
}

void VehicleSimulator::startEngine(){
    if(m_engineRunning)
        return;

    m_engineRunning = true;
    m_updateTimer->start();
    emit engineRunningChanged();
}


void VehicleSimulator::stopEngine() {
    if (!m_engineRunning) return;
    m_engineRunning = false;
    m_updateTimer->stop();

    if (m_vehicleData){
        m_vehicleData->setSpeed(0);
        m_vehicleData->setRpm(0);
    }
    emit engineRunningChanged();
}



void VehicleSimulator::updateVehicle(){
    if (!m_vehicleData) return;

    int currentSpeed = m_vehicleData->speed();
    int currentRpm = m_vehicleData->rpm();

    // update speed and rpm
    if (m_accelerating){
        currentSpeed += 1;
        currentRpm = qMin(m_maxRpm, currentRpm + 50);
        if (currentSpeed >= m_maxSpeed){
            m_accelerating = false;
        }
    } else {
        currentSpeed -= 1;
        currentRpm = qMax(1000, currentRpm - 50);
        if (currentSpeed <= 10){
            m_accelerating = true;
        }
    }

    currentRpm += QRandomGenerator::global()->bounded(-50,50);
    m_vehicleData->setSpeed(currentSpeed);
    m_vehicleData->setRpm(currentRpm);

    
    if (currentSpeed > 0){
        double fuelRate = (currentRpm / 8000.0) * 0.01;
        m_vehicleData->consumeFuel(fuelRate);
    }
}
