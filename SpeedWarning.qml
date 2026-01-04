import QtQuick
import QtQuick.Controls

// Speed warning indicator
// Required C++ property: vehicleData.isOverSpeeding (bool)
Rectangle {
    id: root
    width: 300
    height: 60
    color: "red"
    border.color: "darkred"
    border.width: 3
    radius: 10

    property bool isOverSpeeding: false
    visible: isOverSpeeding

    Text {
        anchors.centerIn: parent
        text: "⚠ SLOW DOWN! ⚠"
        color: "white"
        font.pixelSize: 24
        font.bold: true
    }
}
