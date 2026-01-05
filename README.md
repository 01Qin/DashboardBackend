# DashboardBackend

This project demonstrates the integration of a C++ backend with a QML frontend using the **Qt 6 Meta-Object System**. It covers the implementation of properties, signals, slots, singletons, and simulation logic within a vehicle dashboard context.

---

## 🚀 Features

* **C++ Property System**: Implements the `READ/WRITE/NOTIFY` pattern for seamless data binding between C++ and QML.
* **Singleton Pattern**: Uses `IndicatorController` as a singleton to manage global dashboard states like warning lights and turn signals.
* **Real-time Simulation**: A `VehicleSimulator` class utilizes `QTimer` to drive dashboard data (speed, RPM, fuel) from the C++ event loop.
* **Computed Properties**: Logic for unit conversion (km/h to mph), overspeed detection, and fuel consumption calculation.
* **Trip Computer**: Advanced C++-to-C++ signal/slot connections to track trip distance, time, and average speed.

---

## 🛠 Prerequisites

* **Qt 6.x** (specifically designed for Qt 6 declarative registration)
* **CMake**
* **C++17** or higher
* Basic understanding of QML and C++ classes

---

## 📂 Project Structure

| File | Description |
| :--- | :--- |
| `vehicledata.h/cpp` | Core data model containing speed, RPM, and fuel properties. |
| `indicatorcontroller.h/cpp` | Singleton class managing dashboard warning lights. |
| `vehiclesimulator.h/cpp` | Engine simulation logic using `QTimer`. |
| `tripcomputer.h/cpp` | Logic for calculating trip statistics based on vehicle data. |
| `Main.qml` | The primary UI file integrating all C++ backend components. |

---

## 🔧 Implementation Details

### The Property Pattern
All backend properties follow the standard Qt property macro to ensure QML bindings update automatically:

`Q_PROPERTY(type name READ getter WRITE setter NOTIFY signal)`



### Change Guards
To optimize performance and prevent infinite loops in bindings, all setters include a change guard:

```cpp
void VehicleData::setSpeed(int newSpeed) {
    if (m_speed == newSpeed) 
        return; // Guard prevents unnecessary signal emission
    
    m_speed = newSpeed;
    emit speedChanged();
}
