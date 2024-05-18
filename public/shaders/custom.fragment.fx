#version 300 es
precision mediump float;

// Input
in vec2 model_uv;

// Uniforms
uniform sampler2D image;
uniform vec2 resolution;

// Output
out vec4 FragColor;

void main() {
    vec4 color = texture(image, model_uv);
    
    // normalize coords
    vec2 position = (model_uv * 2.0 - 1.0);

    // calc distance from center of window
    float dist = length(position);
    
    // Apply vignette effect
       // 1.1 controls the intensity of the vignette effect 
       // 0.8 is the distance the vignette starts 
    float vignette = smoothstep(0.8, 1.1, dist);

    // makes edges darker, but keeps center clear
    color.rgb *= 1.0 - vignette; // inverts the vignette value 
    
    FragColor = color;
}
