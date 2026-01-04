#ifndef VEHICLEDATA1_H
#define VEHICLEDATA1_H

#include <QQmlEngine>

#include <QObject>
#include <qqmlregistration.h>


class VehicleData : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    // Exercise 1 properties
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(int rpm READ rpm WRITE setRpm NOTIFY rpmChanged)

    // Exercise 4 properties
    Q_PROPERTY(double fuelLevel READ fuelLevel NOTIFY fuelLevelChanged FINAL)
    Q_PROPERTY(bool isOverSpeeding READ isOverSpeeding NOTIFY isOverSpeedingChanged FINAL)
    Q_PROPERTY(SpeedUnit speedUnit READ speedUnit WRITE setSpeedUnit NOTIFY speedUnitChanged FINAL)
    Q_PROPERTY(int displaySpeed READ displaySpeed NOTIFY displaySpeedChanged FINAL)

public:
    enum class SpeedUnit{
        KilometersPerHour,
        MilePerHour
    };
    Q_ENUM(SpeedUnit)

    explicit VehicleData(QObject *parent = nullptr);
    // Use Qt Creator to generate getters/setters

    // getter --> read
    int speed() const {return m_speed;}
    int rpm() const{return m_rpm;}

    double fuelLevel() const {return m_fuelLevel;}
    SpeedUnit speedUnit() const {return m_speedUnit;}
    bool isOverSpeeding() const {return m_speed > 200;} // computed, shares speedChanged
    int displaySpeed() const; // computed, dedicated signal

    // setter --> write
    void setRpm(int newRpm);
    void setSpeed(int newSpeed);
    void setSpeedUnit(SpeedUnit unit);

    Q_INVOKABLE void resetAll(); // exercise 4

public slots:
    void consumeFuel(double amount); // exercise 4



signals:
    // exercise 1
    void speedChanged();
    void rpmChanged();

    // exercise 4
    void fuelLevelChanged();
    void isOverSpeedingChanged();
    void speedUnitChanged();
    void displaySpeedChanged();

private:
    int m_speed = 0;
    int m_rpm = 0;
    double m_fuelLevel = 100.0;
    SpeedUnit m_speedUnit = SpeedUnit::KilometersPerHour;
};

#endif // VEHICLEDATA1_H
