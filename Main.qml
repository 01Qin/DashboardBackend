import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Dashboard  // EXERCISE 1: Uncomment after registering C++ types

Window {
    id: window
    width: 1600
    height: 800
    visible: true
    title: qsTr("Dashboard")

    // ========================================================================
    // EXERCISE 1: C++ Backend Objects
    // ========================================================================

    VehicleData {
         id: vehicleData
     }

    // ========================================================================
    // EXERCISE 3: VehicleSimulator
    // ========================================================================

     VehicleSimulator {
         id: simulator
         vehicleData: vehicleData
     }

    // ========================================================================
    // EXERCISE 5: Trip Computer (OPTIONAL ADVANCED)
    // ========================================================================
    // After implementing TripComputer class, uncomment these lines:

    //TripComputer {
     //   id: tripComputer
     //   vehicleData: vehicleData
    //}

    Rectangle {
        id: background
        anchors.fill: window.contentItem

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#e6e6e6" }
            GradientStop { position: 0.5; color: "#4d4d4d" }
            GradientStop { position: 0.75; color: "black" }
        }

        SpeedGauge {
            id: speedGauge
            anchors.left: background.left
            anchors.top: background.top

            // EXERCISE 1: After implementing VehicleData, replace this line:
             speed: vehicleData.speed

            // TEMPORARY: QML-only simulation (Remove in EXERCISE 3)
            // (EXERCISE 1: change speedGauge to vehicleData inside the timer)

        }

        RpmGauge {
            anchors.right: background.right
            anchors.top: background.top

            // EXERCISE 1: After implementing VehicleData, use:
            rpm: vehicleData.rpm
        }

        IndicatorPane {
            id: indicatorPane
            anchors.centerIn: background

            // EXERCISE 2: After implementing IndicatorController singleton, use:
             parkingBrakeOn: IndicatorController.parkingBrakeOn
             leftTurnSignalOn: IndicatorController.leftTurnSignalOn
             rightTurnSignalOn: IndicatorController.rightTurnSignalOn
             fuelWarningOn: vehicleData.fuelLevel < 10 // EXERCISE 4: Computed binding ()
        }

        // ====================================================================
        // EXERCISE 4: Speed Warning Component
        // ====================================================================
        // After implementing isOverSpeeding property, uncomment:

         SpeedWarning {
             anchors.horizontalCenter: background.horizontalCenter
             anchors.top: background.top
             anchors.topMargin: 50
             isOverSpeeding: vehicleData.isOverSpeeding
        }

        // ====================================================================
        // EXERCISE 4: Fuel Level Display
        // ====================================================================
        // After implementing fuelLevel property, uncomment:

         FuelDisplay {
             anchors.left: background.left
             anchors.bottom: background.bottom
             anchors.margins: 20
             fuelLevel: vehicleData.fuelLevel
         }

        // ====================================================================
        // EXERCISE 4: Speed Display with Unit
        // ====================================================================
        // After implementing displaySpeed and speedUnit, uncomment:

         SpeedDisplay {
             anchors.right: background.right
             anchors.bottom: background.bottom
             anchors.margins: 20
             displaySpeed: vehicleData.displaySpeed
             speedUnitText: vehicleData.speedUnit === VehicleData.KilometersPerHour ? "km/h" : "mph"
     }

        // ====================================================================
        // EXERCISE 5: Trip Computer Display (OPTIONAL ADVANCED)
        // ====================================================================
        // After implementing TripComputer class, uncomment these lines:

        // TripDisplay {
        //     anchors.horizontalCenter: background.horizontalCenter
        //     anchors.bottom: indicatorPane.top
        //     anchors.bottomMargin: 30
        //     averageSpeed: tripComputer.averageSpeed
        //     tripDistance: tripComputer.tripDistance
        //     tripTime: tripComputer.tripTime
        //     tripActive: tripComputer.tripActive
        // }
    }

    Column {
        anchors.bottom: window.contentItem.bottom
        anchors.horizontalCenter: window.contentItem.horizontalCenter
        anchors.bottomMargin: 10
        spacing: 10

        // ====================================================================
        // EXERCISE 5: Trip Computer Control Buttons (OPTIONAL ADVANCED)
        // ====================================================================
        // After implementing TripComputer class, change visible to true:

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            visible: false  // Change to true after implementing Exercise 5

            // Button {
            //     width: 150
            //     height: 50
            //     text: tripComputer.tripActive ? "Stop Trip" : "Start Trip"
            //     onClicked: {
            //         if (tripComputer.tripActive) {
            //             tripComputer.stopTrip()
            //         } else {
            //             tripComputer.startTrip()
            //         }
            //     }
            // }

            // Button {
            //     width: 150
            //     height: 50
            //     text: "Reset Trip"
            //     enabled: !tripComputer.tripActive
            //     onClicked: {
            //         tripComputer.resetTrip()
            //     }
            // }
        }

        // ====================================================================
        // EXERCISES 1-4: Vehicle Control Buttons
        // ====================================================================

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

        Button {
            width: 150
            height: 50
            text: IndicatorController.leftTurnSignalOn ? "Turn Left Off" : "Turn Left On"
            onClicked: {
                // EXERCISE 2: After implementing IndicatorController, use:
                 IndicatorController.setTurnSignal(IndicatorController.Left)
            }
        }

        Button {
            width: 150
            height: 50
            text: IndicatorController.rightTurnSignalOn ? "Turn Right Off" : "Turn Right On"
            onClicked: {
                // EXERCISE 2: After implementing IndicatorController, use:
                 IndicatorController.setTurnSignal(IndicatorController.Right)
            }
        }

        Button {
            width: 150
            height: 50
            text: indicatorPane.parkingBrakeOn ? "Parking Brake On" : "Parking Brake Off" // EXERCISE 2: indicatorPane -> IndicatorController
            onClicked: {
                // EXERCISE 2: After implementing IndicatorController, use:
                 IndicatorController.toggleParkingBrake()
            }
        }

        Button {
            width: 150
            height: 50
            // EXERCISE 3: After implementing VehicleSimulator, change to:
            text: simulator.engineRunning ? "Stop Engine" : "Start Engine"

            onClicked: {
                // EXERCISE 3: After implementing VehicleSimulator, use:
                 if (simulator.engineRunning) {
                     simulator.stopEngine()
                 } else {
                     simulator.startEngine()
                     if (IndicatorController.parkingBrakeOn) {
                         IndicatorController.toggleParkingBrake()
                     }
                 }

            }
        }

        // ====================================================================
        // EXERCISE 4: Speed Unit Toggle Button
        // ====================================================================
        // After implementing speedUnit property, uncomment:

         Button {
            width: 150
            height: 50
            text: vehicleData.speedUnit === VehicleData.KilometersPerHour ? "km/h" : "mph"
            onClicked: {
                 vehicleData.speedUnit = (vehicleData.speedUnit === VehicleData.KilometersPerHour)
                                          ? VehicleData.MilePerHour
                                          : VehicleData.KilometersPerHour
             }
         }

        // ====================================================================
        // EXERCISE 4: Reset Button
        // ====================================================================
        // After implementing resetAll() method, uncomment:

        Button {
            width: 150
            height: 50
            text: "Reset All"
            onClicked: {
                vehicleData.resetAll()
            }
         }
        }  // End of vehicle control Row
    }  // End of Column
}
