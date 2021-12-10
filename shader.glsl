// https://www.desmos.com/calculator/ic9wgph44d

#ifdef GL_ES
precision mediump float;
#endif

varying vec4 vertTexCoord;

vec3 rgb2hsv(vec3 c) {
  vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
  vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
  vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

  float d = q.x - min(q.w, q.y);
  float e = 1.0e-10;
  return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 0.66666, 0.33333, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, p - K.xxx, c.y);
}

float map(float value, float min1, float max1, float min2, float max2) {
  return clamp(min2 + (value - min1) * (max2 - min2) / (max1 - min1), min(min2, max2), max(min2, max2));
}

float loopMod(float x, float n) {
  return abs(mod(2 * x - n, 2 * n) - n);
}

void main() {
    float x = vertTexCoord.x;
    float y = vertTexCoord.y;
    
    float t = sin(2 * (x - 0.5)) * cos(2 * (y - 0.5)) + x * y;
    vec2 r1 = vec2(0.897,0.7);
    vec2 r2 = vec2(0.94,0.542);
    
    vec3 c1 = hsv2rgb(vec3(mix(r1.x, r1.y, x), 1.0, 1.0));
    vec3 c2 = hsv2rgb(vec3(mix(r2.x, r2.y, y), 1.0, 1.0));
    float newHue = rgb2hsv(mix(c1, c2, t)).x;
    
    gl_FragColor = vec4(hsv2rgb(vec3(newHue, 1.0, 1.0)), 1.0);
}