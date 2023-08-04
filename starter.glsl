precision mediump float;

uniform float u_time;
uniform vec2  u_resolution;

void main()
{
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;

    vec3 color = vec3(0.);

    gl_FragColor = vec4(color, 1.);
}