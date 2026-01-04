#ifndef VEHICLESIMULATOR1_H
#define VEHICLESIMULATOR1_H

#include <QObject>
#include <QTimer>
#include <qqmlregistration.h>

#include "vehicledata1.h"

class VehicleSimulator : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(bool engineRunning READ engineRunning NOTIFY engineRunningChanged FINAL)
    Q_PROPERTY(VehicleData* vehicleData READ vehicleData WRITE setVehicleData NOTIFY vehicleDataChanged FINAL)

public:
    VehicleSimulator(QObject *parent = nullptr);

    // getters
    bool engineRunning() const {return m_engineRunning;}
    VehicleData* vehicleData() const {return m_vehicleData;}

    // setters
    void setVehicleData(VehicleData* data);

    Q_INVOKABLE void startEngine();
    Q_INVOKABLE void stopEngine();

signals:
    void engineRunningChanged();
    void vehicleDataChanged();

private slots:
    void updateVehicle();

private:
    QTimer* m_updateTimer;
    VehicleData* m_vehicleData = nullptr;
    bool m_engineRunning = false;
    bool m_accelerating = true;
    const int m_maxSpeed = 260;
    const int m_maxRpm = 8000;
};


#endif // VEHICLESIMULATOR1_H
