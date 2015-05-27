import QtQuick 2.4
import "js/Cube.js" as Cube

Item {
    id: cube

    property alias frontSideLoader: frontSideLoader
    property alias leftSideLoader: leftSideLoader
    property alias rightSideLoader: rightSideLoader
    property alias topSideLoader: topSideLoader
    property alias bottomSideLoader: bottomSideLoader

    //property int rotationDirection: 0
    //property real rotationPosition: 0

    signal sideSelected(int side)

    function initRotation(mousePos) {
        Cube.initRotation(mousePos)
    }

    function rotate(mousePos) {
        return Cube.rotate(mousePos)
    }

    function animate(mousePos) {
        Cube.animate(mousePos)
    }

    function finishRotation(mousePos) {
        Cube.selectedSide = Cube.finishRotation(mousePos)

        switch(Cube.selectedSide) {
        case Cube.FRONT:
            container.state = "showFrontSide"
            break
        case Cube.RIGHT:
            container.state = "showRightSide"
            break
        case Cube.LEFT:
            container.state = "showLeftSide"
            break
        case Cube.TOP:
            container.state = "showTopSide"
            break
        case Cube.BOTTOM:
            container.state = "showBottomSide"
        }
    }

    Item {
        id: container
        anchors.fill: parent

        Item {
            id: frontSideContainer
            width: parent.width
            height: parent.height
            Loader {
                id: frontSideLoader
                anchors.fill: parent
            }
            transform: Rotation {
                id: frontSideRot
                axis.z: 0
            }
            //onXChanged: rotationPosition = x
            //onYChanged: rotationPosition = y
        }
        Item {
            id: rightSideContainer
            width: parent.width
            height: parent.height
            x: width
            Loader {
                id: rightSideLoader
                anchors.fill: parent
            }
            transform: Rotation {
                id: rightSideRot
                axis {x: 0; y: 1; z: 0}
                angle: 90
                origin {x: 0; y: height/2}
            }
        }
        Item {
            id: leftSideContainer
            width: parent.width
            height: parent.height
            x: -width
            Loader {
                id: leftSideLoader
                anchors.fill: parent
            }
            transform: Rotation {
                id: leftSideRot
                axis {x: 0; y: 1; z: 0}
                angle: 270
                origin {x: width; y: height/2}
            }
        }
        Item {
            id: topSideContainer
            width: parent.width
            height: parent.height
            y: -height
            Loader {
                id: topSideLoader
                anchors.fill: parent
            }
            transform: Rotation {
                id: topSideRot
                axis {x: 1; y: 0; z: 0}
                angle: 90
                origin {x: width/2; y: height}
            }
        }
        Item {
            id: bottomSideContainer
            width: parent.width
            height: parent.height
            y: height
            Loader {
                id: bottomSideLoader
                anchors.fill: parent
            }
            transform: Rotation {
                id: bottomSideRot
                axis {x: 1; y: 0; z: 0}
                angle: 270
                origin {x: width/2; y: 0}
            }
        }

        states: [
            State {
                name: "showFrontSide"
                PropertyChanges { target: frontSideRot; angle: 0 }
                PropertyChanges { target: frontSideContainer; x: 0; y: 0}

                PropertyChanges { target: rightSideRot; angle: 90 }
                PropertyChanges { target: rightSideContainer; x: width }

                PropertyChanges { target: leftSideRot; angle: 270 }
                PropertyChanges { target: leftSideContainer; x: -width }

                PropertyChanges { target: topSideRot; angle: 90 }
                PropertyChanges { target: topSideContainer; y: -height }

                PropertyChanges { target: bottomSideRot; angle: 270 }
                PropertyChanges { target: bottomSideContainer; y: height }
            },
            State {
                name: "showLeftSide"
                PropertyChanges { target: frontSideRot; angle: 90 }
                PropertyChanges { target: frontSideContainer; x: width }

                PropertyChanges { target: leftSideRot; angle: 360 }
                PropertyChanges { target: leftSideContainer; x: 0 }
            },
            State {
                name: "showRightSide"
                PropertyChanges { target: frontSideRot; angle: -90 }
                PropertyChanges { target: frontSideContainer; x: -width }

                PropertyChanges { target: rightSideRot; angle: 0 }
                PropertyChanges { target: rightSideContainer; x: 0 }
            },
            State {
                name: "showTopSide"
                PropertyChanges { target: frontSideRot; angle: -90 }
                PropertyChanges { target: frontSideContainer; y: height }

                PropertyChanges { target: topSideRot; angle: 0 }
                PropertyChanges { target: topSideContainer; y: 0 }
            },
            State {
                name: "showBottomSide"
                PropertyChanges { target: frontSideRot; angle: 90 }
                PropertyChanges { target: frontSideContainer; y: -height }

                PropertyChanges { target: bottomSideRot; angle: 360 }
                PropertyChanges { target: bottomSideContainer; y: 0 }
            }
        ]

        transitions: [
            Transition {
                SequentialAnimation {
                    PropertyAnimation { properties: "angle,x,y"; duration: 150 }
                    ScriptAction {
                        script: { cube.sideSelected(Cube.selectedSide)}
                    }
                }
            }
        ]
    }
}
