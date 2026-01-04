import QtQuick

Item {
    id: root
    width: row.width
    height: row.height
    property bool parkingBrakeOn: false
    property alias leftTurnSignalOn: turnLeftTimer.running
    property alias rightTurnSignalOn: turnRightTimer.running
    property bool fuelWarningOn: false

    Row {
        id: row
        Item {
            id: turnLeftItem
            width: turnLeftIcon.width
            height:  turnLeftIcon.height
            property bool offIconVisible: !root.leftTurnSignalOn ? true : !turnLeftTimer.blinkOn
            Image {
                id: turnLeftIcon
                source: turnLeftItem.offIconVisible ? "images/turnleft_off.png" : "images/turnleft_on.png"
            }
            Timer {
                id: turnLeftTimer
                property bool blinkOn: false
                repeat: true
                interval: 500
                onTriggered: {
                    blinkOn = !blinkOn
                }
            }
        }
        Item {
            id: parkingBrakeItem
            width: parkingBrakeIcon.width
            height: parkingBrakeIcon.height
            Image {
                id: parkingBrakeIcon
                source: "images/parkingbrake_off.png"
                visible: !root.parkingBrakeOn
            }
            Image {
                source: "images/parkingbrake_on.png"
                visible: root.parkingBrakeOn
            }
        }
        Image {
            source: root.fuelWarningOn ? "images/fuel_on.png" : "images/fuel_off.png"
        }
        Item {
            id: turnRightItem
            width: turnRightIcon.width
            height:  turnRightIcon.height
            property bool offIconVisible: !root.rightTurnSignalOn ? true : !turnRightTimer.blinkOn
            Image {
                id: turnRightIcon
                source: turnRightItem.offIconVisible ? "images/turnright_off.png" : "images/turnright_on.png"
            }
            Timer {
                id: turnRightTimer
                property bool blinkOn: false
                repeat: true
                interval: 500
                onTriggered: {
                    blinkOn = !blinkOn
                }
            }
        }
    }

}
