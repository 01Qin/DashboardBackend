import QtQuick

Item {
    id: root

    property int speed: 0
    
    width: gaugeImg.width
    height: gaugeImg.height
    
    Image {
        id: gaugeImg
        source: "images/speedgauge.png"
    }
    Image {
        id: needleImg
        source: "images/needleorange.png"
        transformOrigin: Item.Bottom
        rotation: -136 + root.speed / 260 * 272
        anchors.horizontalCenter: gaugeImg.horizontalCenter
        anchors.verticalCenter: gaugeImg.verticalCenter
        anchors.verticalCenterOffset: -height * 0.5
    }
}
