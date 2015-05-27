import QtQuick 2.4

Effect{
    id: effectBillboard

    property real grid: 20.0
    property real step_x: 0.0015625
    property real step_y: step_x * targetWidth / targetHeight

    fragmentShader: "
            uniform float grid;
            uniform float step_x;
            uniform float step_y;

            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            varying vec2 qt_TexCoord0;

            void main()
            {
                vec2 uv = qt_TexCoord0.xy;
                float offx = floor(uv.x  / (grid * step_x));
                float offy = floor(uv.y  / (grid * step_y));
                vec3 res = texture2D(source, vec2(offx * grid * step_x , offy * grid * step_y)).rgb;
                vec2 prc = fract(uv / vec2(grid * step_x, grid * step_y));
                vec2 pw = pow(abs(prc - 0.5), vec2(2.0));
                float  rs = pow(0.45, 2.0);
                float gr = smoothstep(rs - 0.1, rs + 0.1, pw.x + pw.y);
                float y = (res.r + res.g + res.b) / 3.0;
                vec3 ra = res / y;
                float ls = 0.3;
                float lb = ceil(y / ls);
                float lf = ls * lb + 0.3;
                res = lf * res;
                vec3 col = mix(res, vec3(0.1, 0.1, 0.1), gr);
                gl_FragColor = qt_Opacity * vec4(col, 1.0);
            }"
}
