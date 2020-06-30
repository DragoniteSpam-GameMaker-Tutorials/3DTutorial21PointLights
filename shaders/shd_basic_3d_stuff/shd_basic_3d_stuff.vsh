attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                    // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

uniform vec3 lightPosition;
uniform vec4 lightColor;
uniform float lightRange;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_worldPosition;

void main() {
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_worldPosition = (gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos).xyz;
    
    vec4 lightAmbient = vec4(0.25, 0.25, 0.25, 1.);
    
    // Directional light stuff
    /*
    vec3 lightDir = normalize(-lightDirection);
    vec3 worldNormal = normalize(gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.)).xyz;
    
    float lightAngleDifference = max(dot(worldNormal, lightDir), 0.);
    */
    
    // Point light stuff
    vec3 worldPosition = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1.)).xyz;
    vec3 worldNormal = normalize(gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.)).xyz;
    vec3 lightDir = worldPosition - lightPosition;
    float lightDist = length(lightDir);
    float att = max((lightRange - lightDist) / lightRange, 0.);
    
    lightDir = normalize(-lightDir);
    float lightAngleDifference = max(dot(worldNormal, lightDir), 0.);
    
    v_vColour = in_Colour * vec4(min(lightAmbient + att * lightColor * lightAngleDifference, vec4(1.)).rgb, in_Colour.a);
    v_vTexcoord = in_TextureCoord;
}