// disco office 2000 ultra delux by Anette von Kapri and Valentin Heun
// with this processing sketch you can run the 40 * 30 ceiling screen in our office (548K) from everywhere in MIT Network.
// oscP5 library is needed: http://www.sojamo.de/libraries/oscP5/index.html


import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;


PImage input;

final int light_strings = 30;
final int lights_per_string = 40;
// The Screen has 40 * 30 Pixel


void setup() {
  size(40,30);
  frameRate(30);
 
 //OSC
 OscProperties myProperties = new OscProperties();

  myProperties.setDatagramSize(5400); 
  myProperties.setListeningPort(12001);
  oscP5 = new OscP5(this,myProperties);

// Display ip is 18.85.58.180 and OSC talks at port 12000 
 myRemoteLocation = new NetAddress("18.85.58.180",12000);
}

void draw() {

    OscMessage myMessage = new OscMessage("/Computer1");
  
  for(int i=0; i<(light_strings); i++)
  {
    for(int j=0; j<lights_per_string; j++)
    {
      int pixelColor = 0;
      if(i==27)
       pixelColor = 255;
     myMessage.add(pixelColor); 
     //send image as array of integer RGB values
    }
 
   }
  
  oscP5.send(myMessage, myRemoteLocation); // Send to our Office
  
}

