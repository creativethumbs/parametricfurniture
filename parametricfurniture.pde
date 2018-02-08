import processing.dxf.*; 

boolean export = true; 
float xoff = 0.0;

PShape blob; 


void setup() { 
  //noFill(); 
  size(500, 500, P3D);  

  smooth(); 
  pixelDensity(2);
  
  blob = createShape(); 
  
  // blob is a circle affected by perlin noise
  float t = 0; 
  blob.beginShape();
  for (float a = 0; a <= TWO_PI; a += TWO_PI/30) {
    
    float noiseMult = noise(cos(a)*1.2+1,sin(a)*1.2+1, t);  
    noiseMult = map(noiseMult, 0,1, 0.4,1); 

    float x = cos(a)*(width/5) *noiseMult;
    float y = sin(a)*(width/5) *noiseMult; 
    blob.vertex(x, y);
    
    t += 0.002; 
  }

  blob.endShape(CLOSE);
} 

void draw() {
  background(125); 
  translate(width/2, height/2);
  
  if (export) {
    beginRaw(DXF, "output.dxf");
  } 

  noFill();  

  shape(blob,0,0); 
  
  //scale(0.7); 
  //shape(blob,0,0); 

  saveFrame();
  //exit(); 
  if (export) {
    endRaw(); 
    exit();
  }
}