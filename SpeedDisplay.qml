import QtQuick
import QtQuick.Controls

// Speed display with unit support
// Required C++ properties:
//   - vehicleData.displaySpeed (int)
//   - vehicleData.speedUnit (enum: KilometersPerHour or MilesPerHour)
Rectangle {
    id: root
    width: 250
    height: 80
    color: "#2b2b2b"
    border.color: "#4CAF50"
    border.width: 2
    radius: 5

    property int displaySpeed: 0
    property string speedUnitText: "km/h"

    Column {
        anchors.centerIn: parent
        spacing: 5

        Text {
            text: "Current Speed"
            color: "#4CAF50"
            font.pixelSize: 16
        }

        Text {
            text: root.displaySpeed + " " + root.speedUnitText
            color: "white"
            font.pixelSize: 24
            font.bold: true
        }
    }
}
