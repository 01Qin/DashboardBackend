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
    //    C++ Backend Objects
    // ========================================================================

    VehicleData {
         id: vehicleData
     }

    // ========================================================================
    // VehicleSimulator
    // ========================================================================

     VehicleSimulator {
         id: simulator
         vehicleData: vehicleData
     }

    // ========================================================================
    // Trip Computer 
    // ========================================================================
    

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

             speed: vehicleData.speed

        

        }

        RpmGauge {
            anchors.right: background.right
            anchors.top: background.top

            rpm: vehicleData.rpm
        }

        IndicatorPane {
            id: indicatorPane
            anchors.centerIn: background

             parkingBrakeOn: IndicatorController.parkingBrakeOn
             leftTurnSignalOn: IndicatorController.leftTurnSignalOn
             rightTurnSignalOn: IndicatorController.rightTurnSignalOn
             fuelWarningOn: vehicleData.fuelLevel < 10 // Computed binding ()
        }

        // ====================================================================
        // Speed Warning Component
        // ====================================================================
        

         SpeedWarning {
             anchors.horizontalCenter: background.horizontalCenter
             anchors.top: background.top
             anchors.topMargin: 50
             isOverSpeeding: vehicleData.isOverSpeeding
        }

        // ====================================================================
        // Fuel Level Display
        // ====================================================================

         FuelDisplay {
             anchors.left: background.left
             anchors.bottom: background.bottom
             anchors.margins: 20
             fuelLevel: vehicleData.fuelLevel
         }

        // ====================================================================
        // Speed Display with Unit
        // ====================================================================

         SpeedDisplay {
             anchors.right: background.right
             anchors.bottom: background.bottom
             anchors.margins: 20
             displaySpeed: vehicleData.displaySpeed
             speedUnitText: vehicleData.speedUnit === VehicleData.KilometersPerHour ? "km/h" : "mph"
     }

        // ====================================================================
        // Trip Computer Display 
        // ====================================================================

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
        // Trip Computer Control Buttons
        // ====================================================================

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            visible: false 

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
        // Vehicle Control Buttons
        // ====================================================================

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

        Button {
            width: 150
            height: 50
            text: IndicatorController.leftTurnSignalOn ? "Turn Left Off" : "Turn Left On"
            onClicked: {
                 IndicatorController.setTurnSignal(IndicatorController.Left)
            }
        }

        Button {
            width: 150
            height: 50
            text: IndicatorController.rightTurnSignalOn ? "Turn Right Off" : "Turn Right On"
            onClicked: {
                 IndicatorController.setTurnSignal(IndicatorController.Right)
            }
        }

        Button {
            width: 150
            height: 50
            text: indicatorPane.parkingBrakeOn ? "Parking Brake On" : "Parking Brake Off"
            onClicked: {
                 IndicatorController.toggleParkingBrake()
            }
        }

        Button {
            width: 150
            height: 50
            text: simulator.engineRunning ? "Stop Engine" : "Start Engine"

            onClicked: {

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
        // Speed Unit Toggle Button
        // ====================================================================

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
        // Reset Button
        // ====================================================================

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

