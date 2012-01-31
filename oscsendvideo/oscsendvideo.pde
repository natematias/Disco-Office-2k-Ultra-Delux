// disco office 2000 ultra delux by Anette von Kapri and Valentin Heun
// with this processing sketch you can run the 40 * 30 ceiling screen in our office (548K) from everywhere in MIT Network.
// oscP5 library is needed: http://www.sojamo.de/libraries/oscP5/index.html
// GSVideo library is needed: http://gsvideo.sourceforge.net/


import oscP5.*;
import netP5.*;

import codeanticode.gsvideo.*;

GSMovie myMovie;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

PImage input2;

final int light_strings = 30;
final int lights_per_string = 40;
// The Screen has 40 * 30 Pixel



void setup() {
  size(lights_per_string,light_strings);
  frameRate(30);
  

  myMovie = new GSMovie(this, "station.mov");
  myMovie.loop();
  input2 =  new PImage(lights_per_string,light_strings); 
 
 //OSC
  OscProperties myProperties = new OscProperties();

  myProperties.setDatagramSize(5400); 
  myProperties.setListeningPort(12001);
  oscP5 = new OscP5(this,myProperties);
  
 // Display ip is 18.85.58.180 and OSC talks at port 12000 
 myRemoteLocation = new NetAddress("18.85.58.180",12000);
}

void movieEvent(GSMovie myMovie) {
  myMovie.read();
}




void draw() {
    input2.copy(myMovie, 0, 0, myMovie.width, myMovie.height, 0, 0, lights_per_string, light_strings);
  image(input2,0,0);
  
  input2.loadPixels();
  OscMessage myMessage = new OscMessage("/Computer1");
  
  
  for(int i=0; i<(lights_per_string * light_strings); i++)
  {
     int pixelColor = input2.pixels[i];
     myMessage.add(pixelColor);
     //send image as array of integer RGB values
  }
  
  oscP5.send(myMessage, myRemoteLocation);  // Send to our Office


}



