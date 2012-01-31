// disco office 2000 ultra delux by Anette von Kapri and Valentin Heun
// with this processing sketch you can run the 40 * 30 ceiling screen in our office (548K) from everywhere in MIT Network.
// oscP5 library is needed: http://www.sojamo.de/libraries/oscP5/index.html


import oscP5.*;
import netP5.*;

import java.awt.Color;

OscP5 oscP5;
NetAddress myRemoteLocation;

// The Screen has 40 * 30 Pixel
final int light_strings = 30;
final int lights_per_string = 40;

void setup(){
  size(light_strings, lights_per_string);
  
  frameRate(25);
  
  //OSC
  OscProperties myProperties = new OscProperties();

  myProperties.setDatagramSize(5400); 
  myProperties.setListeningPort(12001);
  oscP5 = new OscP5(this,myProperties);
  
  // Display ip is 18.85.58.180 and OSC talks at port 12000 
  myRemoteLocation = new NetAddress("18.85.58.180",12000);
  
  
  ellipseMode(CENTER);
  smooth();
  noFill();
  background(255);

}

void sendScreenToCeiling(){
  OscMessage myMessage = new OscMessage("/Computer1");  
  PixelBuffer buf = new PixelBuffer( light_strings, lights_per_string );
  buf.loadFromScreen();
  buf.serialize( myMessage );
  oscP5.send(myMessage, myRemoteLocation);  // Send to our Office
}

int counter=0;

PVector[] circles = new PVector[256];
float[] circlewidths = new float[256];
int ncircles=0;

void mousePressed() {
  circles[ncircles%256]=new PVector(mouseX,mouseY);
  circlewidths[ncircles%256]=0;
  ncircles += 1;
}

void draw(){

  //background(128,128,255);
  //background(244,164,96);
  background(0,0,0);
  
  line(pmouseX, pmouseY, mouseX, mouseY);
  
  for(int i=0; i<ncircles; i++) {
    stroke(color(128,128,255));
    ellipse( circles[i].x, circles[i].y, circlewidths[i], circlewidths[i] );
    circlewidths[i] += 0.5;
  }
  
  sendScreenToCeiling();
  
}
