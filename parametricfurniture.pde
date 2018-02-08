import processing.dxf.*;
import processing.pdf.*;

boolean dxfexport = true;
boolean pdfexport = true; 

float xoff = 0.0;

PShape blob;  

int frame = 0; 

void setup() { 
  noFill(); 
  size(500, 500, P3D);  

  smooth(); 
  pixelDensity(2);
  stroke(0.0001);

  blob = createShape();  

  // blob is a circle affected by perlin noise
  float t = 0; 
  blob.beginShape();
  for (float a = 0; a <= TWO_PI; a += TWO_PI/30) {

    float noiseMult = noise(cos(a)*1.2+1, sin(a)*1.2+1, t);  
    noiseMult = map(noiseMult, 0, 1, 0.4, 1); 

    float x = cos(a)*(width/5) *noiseMult;
    float y = sin(a)*(width/5) *noiseMult; 
    blob.vertex(x, y);

    t += 0.002;
  }

  blob.endShape(CLOSE);
} 

void blob() {
  stroke(0.0001);
  noFill(); 

  shape(blob, 0, 0); 
}

void blobwithhole() {
  stroke(0.0001);
  noFill(); 

  shape(blob, 0, 0); 
  
  pushMatrix();
  scale(0.7); 
  shape(blob, 0, 0);
  popMatrix(); 
}

void draw() {

  if (pdfexport) {
    drawpdf(); 
  }
  
  if (dxfexport) {
    drawdxf();
  }  
  
  exit();
}

void drawpdf() {
  //beginRecord( PDF, "pdf/myartwork-####.pdf" ); 

  pushMatrix(); 
  translate(width/2, height/2);
  scale(2); 

  for (int i = 1; i <= 15; i++) { 
    noStroke();
    fill(255);
    rect(-width/2, -height/2, width, height);
    
    pushMatrix();
    
    rotate(radians(i*5)); 
    scale(pow(0.95, i)); 
     
    blobwithhole();
    popMatrix(); 
    
    
    pushMatrix(); 
    translate(30,30); 
    scale(1f,1f,-1f); 
    
    rotate(radians(i*5)); 
    scale(0.8); 
     
    blob();
    popMatrix(); 

    save("lasercuts/hole-"+i+".tif");  
    
    clear(); 
  } 
  
  for (int i = 1; i <= 17; i++) {
    noStroke();
    fill(255);
    rect(-width/2, -height/2, width, height);
    
    pushMatrix();
    
    rotate(radians(-i*3)); 
    scale(pow(0.98, i)); 
     
    blob();
    popMatrix(); 
    
    save("lasercuts/bottom-"+i+".tif");  
    
    clear(); 
  }
  
  popMatrix();
  
  //endRecord();
}


void drawdxf() {
  background(125); 
  fill(255); 

  translate(width/2, height/2);

  beginRaw(DXF, "output.dxf");


  noFill();  

  scale(2);
  shape(blob, 0, 0);  

  saveFrame(); 

  endRaw(); 
  
}