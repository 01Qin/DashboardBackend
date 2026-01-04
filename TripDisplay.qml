import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Trip computer display component
// Shows average speed, distance, and trip time
Rectangle {
    id: root
    width: 250
    height: 180
    color: "#2b2b2b"
    border.color: "#4CAF50"
    border.width: 2
    radius: 10

    required property double averageSpeed
    required property double tripDistance
    required property int tripTime
    required property bool tripActive

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        Text {
            text: "Trip Computer"
            color: "#4CAF50"
            font.pixelSize: 18
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#4CAF50"
        }

        // Average Speed
        Row {
            Layout.fillWidth: true
            spacing: 10

            Text {
                text: "Avg Speed:"
                color: "white"
                font.pixelSize: 14
                width: 100
            }

            Text {
                text: root.averageSpeed.toFixed(1) + " km/h"
                color: root.tripActive ? "#4CAF50" : "#888"
                font.pixelSize: 14
                font.bold: true
            }
        }

        // Trip Distance
        Row {
            Layout.fillWidth: true
            spacing: 10

            Text {
                text: "Distance:"
                color: "white"
                font.pixelSize: 14
                width: 100
            }

            Text {
                text: root.tripDistance.toFixed(2) + " km"
                color: root.tripActive ? "#4CAF50" : "#888"
                font.pixelSize: 14
                font.bold: true
            }
        }

        // Trip Time
        Row {
            Layout.fillWidth: true
            spacing: 10

            Text {
                text: "Time:"
                color: "white"
                font.pixelSize: 14
                width: 100
            }

            Text {
                function formatTime(seconds) {
                    var hours = Math.floor(seconds / 3600)
                    var minutes = Math.floor((seconds % 3600) / 60)
                    var secs = seconds % 60
                    return (hours < 10 ? "0" : "") + hours + ":" +
                           (minutes < 10 ? "0" : "") + minutes + ":" +
                           (secs < 10 ? "0" : "") + secs
                }
                text: formatTime(root.tripTime)
                color: root.tripActive ? "#4CAF50" : "#888"
                font.pixelSize: 14
                font.bold: true
                font.family: "Courier"
            }
        }

        // Status indicator
        Rectangle {
            Layout.fillWidth: true
            height: 25
            color: root.tripActive ? "#4CAF50" : "#666"
            radius: 5
            
            Text {
                anchors.centerIn: parent
                text: root.tripActive ? "● ACTIVE" : "○ STOPPED"
                color: "white"
                font.pixelSize: 12
                font.bold: true
            }
        }
    }
}
