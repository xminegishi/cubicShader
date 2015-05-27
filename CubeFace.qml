import QtQuick 2.4

Rectangle {
    id: cubeFace

    property string effectSource

    anchors.fill: parent
    Image {
        id: effectImg
        anchors.fill: parent
        source: "images/osaru.png"
    }
    Loader {
        id: effectLoader
        source: effectSource
    }
    ShaderEffectSource {
        id: effectItem
        smooth: true
        hideSource: true
    }
    onEffectSourceChanged: {
        effectLoader.source = effectSource
        if(effectLoader.item) {
            effectLoader.item.parent = cubeFace
            effectLoader.item.targetWidth = cubeFace.width
            effectLoader.item.targetHeight = cubeFace.height
            effectItem.sourceItem = effectImg
            effectLoader.item.source = effectItem
            effectLoader.item.anchors.fill = effectImg
        }
    }
}
