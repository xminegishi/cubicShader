import QtQuick 2.4
import QtQuick.Window 2.2
import "js/CubeView.js" as CubeView

Window {
    visible: true
    width: 360
    height: 360

    CubeView {
        id: cube
        //width: parent.width
        //height: parent.height / 2
        anchors.fill: parent
        currentView: CubeView.FRONT
    }
}

