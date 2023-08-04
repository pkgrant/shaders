precision mediump float;

// Uniforms (values that can be set externally)
uniform float u_time; // Time in seconds since the shader started
uniform vec2 u_resolution; // Screen resolution (width, height)

varying vec4 v_normal;

void main()
{
    // Normalize pixel coordinates to range [0, 1]
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;

    //ambient
    vec3 ambient = vec3(.1);

    //diffuse
    vec3 normal      = normalize(v_normal.xyz);
    //vec3 lightColor  = vec3(.5, .5, .5 + .5 * sin(u_time));
    vec3 lightColor  = vec3(.5, .5, .5);
    vec3 lightSource = vec3(.5, .1, .1);

    //flash bang
    float duration = u_time - floor(u_time);
    if(duration > .9) {
        float boomTimer = floor(u_time);
        if(mod(boomTimer, 5.) == 0.) {
            lightColor *= 3.;
        }
    }

    float diffuseStrength = max(0., dot (lightSource, normal));
    vec3  diffuse         = diffuseStrength * lightColor;

    //specular light
    vec3 cameraSource  = vec3(0., 0., 1.);
    vec3 viewSource    = normalize(cameraSource);
    vec3 reflectSource = normalize(reflect(-lightSource, normal));
    float specularStrength = max(0., dot(viewSource, reflectSource));
    specularStrength   = pow(specularStrength, 16.0);
    vec3 specular = specularStrength * lightColor;

    //vec3 modelColor = vec3(.1 + .1*cos(u_time), .5, .5);
    vec3 lighting   = ambient + diffuse + specular;
    
    //vec3 color = modelColor * lighting;

    // Output the color to the screen
    gl_FragColor = vec4((lighting), 1.0);
}