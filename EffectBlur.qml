import QtQuick 2.4

Item {
    id: effectBlur

    property alias targetWidth: verticalShader.targetWidth
    property alias targetHeight: verticalShader.targetHeight
    property alias source: verticalShader.source

    Effect {
        id: verticalShader
        anchors.fill:  parent
        property real blurSize: 4.0 * 0.5 / targetHeight
        fragmentShader: "
                uniform float blurSize;

                uniform sampler2D source;
                uniform lowp float qt_Opacity;
                varying vec2 qt_TexCoord0;

                void main()
                {
                    vec2 uv = qt_TexCoord0.xy;
                    vec4 c = vec4(0.0);
                        c += texture2D(source, uv - vec2(0.0, 4.0*blurSize)) * 0.05;
                        c += texture2D(source, uv - vec2(0.0, 3.0*blurSize)) * 0.09;
                        c += texture2D(source, uv - vec2(0.0, 2.0*blurSize)) * 0.12;
                        c += texture2D(source, uv - vec2(0.0, 1.0*blurSize)) * 0.15;
                        c += texture2D(source, uv) * 0.18;
                        c += texture2D(source, uv + vec2(0.0, 1.0*blurSize)) * 0.15;
                        c += texture2D(source, uv + vec2(0.0, 2.0*blurSize)) * 0.12;
                        c += texture2D(source, uv + vec2(0.0, 3.0*blurSize)) * 0.09;
                        c += texture2D(source, uv + vec2(0.0, 4.0*blurSize)) * 0.05;
                    // First pass we don't apply opacity
                    gl_FragColor = c;
                }"
    }

    Effect {
        id: horizontalShader
        anchors.fill: parent
        property real blurSize: 4.0 * 0.5 / parent.targetWidth
        fragmentShader: "
                uniform float blurSize;

                uniform sampler2D source;
                uniform lowp float qt_Opacity;
                varying vec2 qt_TexCoord0;

                void main()
                {
                    vec2 uv = qt_TexCoord0.xy;
                    vec4 c = vec4(0.0);
                        c += texture2D(source, uv - vec2(4.0*blurSize, 0.0)) * 0.05;
                        c += texture2D(source, uv - vec2(3.0*blurSize, 0.0)) * 0.09;
                        c += texture2D(source, uv - vec2(2.0*blurSize, 0.0)) * 0.12;
                        c += texture2D(source, uv - vec2(1.0*blurSize, 0.0)) * 0.15;
                        c += texture2D(source, uv) * 0.18;
                        c += texture2D(source, uv + vec2(1.0*blurSize, 0.0)) * 0.15;
                        c += texture2D(source, uv + vec2(2.0*blurSize, 0.0)) * 0.12;
                        c += texture2D(source, uv + vec2(3.0*blurSize, 0.0)) * 0.09;
                        c += texture2D(source, uv + vec2(4.0*blurSize, 0.0)) * 0.05;
                    gl_FragColor = qt_Opacity * c;
                }"
        source: horizontalShaderSource

        ShaderEffectSource {
            id: horizontalShaderSource
            sourceItem: verticalShader
            smooth: true
            hideSource: true
        }
    }
}
