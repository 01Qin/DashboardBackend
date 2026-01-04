import QtQuick

Item {
    id: root

    property int rpm: 0
    
    width: gaugeImg.width
    height: gaugeImg.height

    Image {
        id: gaugeImg
        source: "images/rpmgauge.png"
    }

    Image {
        id: needlered
        source: "images/needlered.png"
        transformOrigin: Item.Bottom
        rotation: -120 + root.rpm / 8000 * 240
        anchors.horizontalCenter: gaugeImg.horizontalCenter
        anchors.verticalCenter: gaugeImg.verticalCenter
        anchors.verticalCenterOffset: -height * 0.5
    }
}
