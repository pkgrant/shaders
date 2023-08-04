precision mediump float;

uniform float u_time;
uniform vec2  u_resolution;

void main()
{
    vec2 uv = gl_FragCoord.xy / u_resolution;

    // uv.y *= u_resolution.y / u_resolution.x;
    // uv.x *= u_resolution.x / u_resolution.y;

    vec3 color = vec3(0.);

    // Results will return 1. or 0.
    //float left = step(0.1, uv.x);
    //float bot  = step(0.1, uv.y);

    //bottom left
    vec2  bl  = smoothstep(.19, 0.2, uv);
    float pct = bl.x * bl.y;

    //top right
    vec2 tr = smoothstep(.19, .2, 1. - uv);
    pct *= tr.x * tr.y;

    color = vec3(pct);

    gl_FragColor = vec4(color, 1.);
}