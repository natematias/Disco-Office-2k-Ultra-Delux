// disco office 2000 ultra delux by Anette von Kapri and Valentin Heun
// with this processing sketch you can run the 40 * 30 ceiling screen in our office (548K) from everywhere in MIT Network.
// oscP5 library is needed: http://www.sojamo.de/libraries/oscP5/index.html


import oscP5.*;
import netP5.*;

import java.awt.Color;

import ddf.minim.*;

Minim minim;
AudioInput in;


OscP5 oscP5;
NetAddress myRemoteLocation;

// The Screen has 40 * 30 Pixel
final int light_strings = 30;
final int lights_per_string = 40;

void setup(){
  size(30, 40);
  
  frameRate(25);

  minim = new Minim(this);
  minim.debugOn();
  
  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.MONO, 40);
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
  PixelBuffer buf = new PixelBuffer(light_strings, lights_per_string);
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

    background(0);
  stroke(255);
  
  // draw the waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line(i, 15 + in.left.get(i)*15, i+1, 15 + in.left.get(i+1)*15);
   
  }

  
  sendScreenToCeiling();
  
}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
  
  super.stop();
}
