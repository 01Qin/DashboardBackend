import QtQuick
import QtQuick.Controls

// Fuel level display component
// Required C++ property: vehicleData.fuelLevel (double, 0-100)
Rectangle {
    id: root
    width: 200
    height: 80
    color: "#2b2b2b"
    border.color: fuelLevel < 10 ? "red" : "#4CAF50"
    border.width: 2
    radius: 5

    property double fuelLevel: 100.0

    Column {
        anchors.centerIn: parent
        spacing: 5

        Text {
            text: "Fuel Level"
            color: "#4CAF50"
            font.pixelSize: 16
        }

        Text {
            text: root.fuelLevel.toFixed(1) + "%"
            color: root.fuelLevel < 10 ? "red" : "white"
            font.pixelSize: 24
            font.bold: true
        }
    }
}
