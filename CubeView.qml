import QtQuick 2.4
import QtGraphicalEffects 1.0
import "js/CubeView.js" as CubeView
import "js/Cube.js" as Cube

Loader {
    id: loader
    sourceComponent: undefined

    property int currentView

    //property int rotationPosition: 0
    //property int rotationDirection: 0

    property int topCubeSide: CubeView.TOP
    property int frontCubeSide: CubeView.FRONT
    property int rightCubeSide: CubeView.RIGHT
    property int leftCubeSide: CubeView.LEFT
    property int bottomCubeSide: CubeView.BOTTOM

    property string frontShaderEffect
    property string leftShaderEffect
    property string rightShaderEffect
    property string topShaderEffect
    property string bottomShaderEffect

    Component.onCompleted: {
        staticCubeFace.effectSource = CubeView._facesShader[CubeView.FRONT]
        loader.sourceComponent = cubeComponent
        updateView()
    }

    function updateView() {
        switch (loader.currentView) {
        case CubeView.TOP:
            frontShaderEffect = CubeView._facesShader[CubeView.TOP]
            leftShaderEffect = CubeView._facesShader[CubeView.LEFT]
            rightShaderEffect = CubeView._facesShader[CubeView.RIGHT]
            topShaderEffect = CubeView._facesShader[CubeView.BOTTOM]
            bottomShaderEffect = CubeView._facesShader[CubeView.FRONT]
            frontCubeSide = CubeView.TOP
            leftCubeSide = CubeView.LEFT
            rightCubeSide = CubeView.RIGHT
            topCubeSide = CubeView.BOTTOM
            bottomCubeSide = CubeView.FRONT
            break

        case CubeView.FRONT:
            frontShaderEffect = CubeView._facesShader[CubeView.FRONT]
            leftShaderEffect = CubeView._facesShader[CubeView.LEFT]
            rightShaderEffect = CubeView._facesShader[CubeView.RIGHT]
            topShaderEffect = CubeView._facesShader[CubeView.TOP]
            bottomShaderEffect = CubeView._facesShader[CubeView.BOTTOM]
            frontCubeSide = CubeView.FRONT
            leftCubeSide = CubeView.LEFT
            rightCubeSide = CubeView.RIGHT
            topCubeSide = CubeView.TOP
            bottomCubeSide = CubeView.BOTTOM
            break

        case CubeView.RIGHT:
            frontShaderEffect = CubeView._facesShader[CubeView.RIGHT]
            leftShaderEffect = CubeView._facesShader[CubeView.FRONT]
            rightShaderEffect = CubeView._facesShader[CubeView.LEFT]
            topShaderEffect = CubeView._facesShader[CubeView.TOP]
            bottomShaderEffect = CubeView._facesShader[CubeView.BOTTOM]
            frontCubeSide = CubeView.RIGHT
            leftCubeSide = CubeView.FRONT
            rightCubeSide = CubeView.LEFT
            topCubeSide = CubeView.TOP
            bottomCubeSide = CubeView.BOTTOM
            break

        case CubeView.LEFT:
            frontShaderEffect = CubeView._facesShader[CubeView.LEFT]
            leftShaderEffect = CubeView._facesShader[CubeView.RIGHT]
            rightShaderEffect = CubeView._facesShader[CubeView.FRONT]
            topShaderEffect = CubeView._facesShader[CubeView.TOP]
            bottomShaderEffect = CubeView._facesShader[CubeView.BOTTOM]
            frontCubeSide = CubeView.LEFT
            leftCubeSide = CubeView.RIGHT
            rightCubeSide = CubeView.FRONT
            topCubeSide = CubeView.TOP
            bottomCubeSide = CubeView.BOTTOM
            break

        case CubeView.BOTTOM:
            frontShaderEffect = CubeView._facesShader[CubeView.BOTTOM]
            leftShaderEffect = CubeView._facesShader[CubeView.LEFT]
            rightShaderEffect = CubeView._facesShader[CubeView.RIGHT]
            topShaderEffect = CubeView._facesShader[CubeView.FRONT]
            bottomShaderEffect = CubeView._facesShader[CubeView.TOP]
            frontCubeSide = CubeView.BOTTOM
            leftCubeSide = CubeView.LEFT
            rightCubeSide = CubeView.RIGHT
            topCubeSide = CubeView.FRONT
            bottomCubeSide = CubeView.TOP
        }
    }

    Component {
        id: cubeComponent

        Cube {
            id: cube

            frontSideLoader.sourceComponent: CubeFace {
                id: frontFace
                effectSource: frontShaderEffect
            }
            leftSideLoader.sourceComponent: CubeFace {
                id: leftFace
                effectSource: leftShaderEffect
            }
            rightSideLoader.sourceComponent: CubeFace {
                id: rightFace
                effectSource: rightShaderEffect
            }
            topSideLoader.sourceComponent: CubeFace {
                id: topFace
                effectSource: topShaderEffect
            }
            bottomSideLoader.sourceComponent: CubeFace {
                id: bottomFace
                effectSource: bottomShaderEffect
            }

            onSideSelected: {
                //var prevView = loader.currentView
                switch(side) {
                case Cube.LEFT:
                    switch(loader.currentView) {
                    case CubeView.FRONT:
                    case CubeView.TOP:
                    case CubeView.BOTTOM:
                        loader.currentView = CubeView.LEFT
                        break
                    case CubeView.RIGHT:
                        loader.currentView = CubeView.FRONT
                        break
                    case CubeView.LEFT:
                        loader.currentView = CubeView.RIGHT
                    }
                    break
                case Cube.RIGHT:
                    switch(loader.currentView) {
                    case CubeView.FRONT:
                    case CubeView.TOP:
                    case CubeView.BOTTOM:
                        loader.currentView = CubeView.RIGHT
                        break
                    case CubeView.LEFT:
                        loader.currentView = CubeView.FRONT
                        break
                    case CubeView.RIGHT:
                        loader.currentView = CubeView.LEFT
                    }
                    break
                case Cube.TOP:
                    switch(loader.currentView) {
                    case CubeView.FRONT:
                    case CubeView.LEFT:
                    case CubeView.RIGHT:
                        loader.currentView = CubeView.TOP
                        break
                    case CubeView.BOTTOM:
                        loader.currentView = CubeView.FRONT
                        break
                    case CubeView.TOP:
                        loader.currentView = CubeView.BOTTOM
                    }
                    break
                case Cube.BOTTOM:
                    switch(loader.currentView) {
                    case CubeView.FRONT:
                    case CubeView.LEFT:
                    case CubeView.RIGHT:
                        loader.currentView = CubeView.BOTTOM
                        break
                    case CubeView.TOP:
                        loader.currentView = CubeView.FRONT
                        break
                    case CubeView.BOTTOM:
                        loader.currentView = CubeView.TOP
                    }
                    break
                }
                switch(loader.currentView) {
                case CubeView.FRONT:
                    staticCubeFace.effectSource = CubeView._facesShader[CubeView.FRONT]
                    break
                case CubeView.LEFT:
                    staticCubeFace.effectSource = CubeView._facesShader[CubeView.LEFT]
                    break
                case CubeView.RIGHT:
                    staticCubeFace.effectSource = CubeView._facesShader[CubeView.RIGHT]
                    break
                case CubeView.TOP:
                    staticCubeFace.effectSource = CubeView._facesShader[CubeView.TOP]
                    break
                case CubeView.BOTTOM:
                    staticCubeFace.effectSource = CubeView._facesShader[CubeView.BOTTOM]
                }
                staticSide.visible = true
                loader.sourceComponent = undefined
                loader.sourceComponent = cubeComponent
                frontShaderEffect = ""
                leftShaderEffect = ""
                rightShaderEffect = ""
                topShaderEffect = ""
                bottomShaderEffect = ""
                updateView()
            }
            //onRotationPositionChanged: loader.rotationPosition = rotationPosition
            //onRotationDirectionChanged: loader.rotationDirection = rotationDirection
        }
    }

    Item {
        id: staticSide
        anchors.fill: parent
        visible: true
        z: 1
        CubeFace {
            id: staticCubeFace
            effectSource: ""
        }
    }

    MouseArea {
        property bool cubeMoving: false
        anchors.fill: parent

        onPressed: {
            staticSide.visible = false
            staticCubeFace.effectSource = ""
            loader.item.initRotation(mouse)
            cubeMoving = false
        }

        onPositionChanged: {
            cubeMoving = loader.item.rotate(mouse)
        }

        onReleased: {
            if(loader.item) {
                if(!cubeMoving)
                    loader.item.animate(mouse)

                loader.item.finishRotation(mouse)
            }
            cubeMoving = false
        }
    }
}
