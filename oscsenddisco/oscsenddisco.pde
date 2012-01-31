// disco office 2000 ultra delux by Anette von Kapri and Valentin Heun
// with this processing sketch you can run the 40 * 30 ceiling screen in our office (548K) from everywhere in MIT Network.
// oscP5 library is needed: http://www.sojamo.de/libraries/oscP5/index.html


import oscP5.*;
import netP5.*;

import java.awt.Color;

OscP5 oscP5;
NetAddress myRemoteLocation;


int counter, ie;
int[] color_count;
//int color_count;



final int light_strings = 30;
final int lights_per_string = 40;
// The Screen has 40 * 30 Pixel


void setup(){
  frameRate(25);
  
  
  counter = 0;
 // color_count = 0;
  
   //OSC
  OscProperties myProperties = new OscProperties();

  myProperties.setDatagramSize(5400); 
  myProperties.setListeningPort(12001);
  oscP5 = new OscP5(this,myProperties);
  
 // Display ip is 18.85.58.180 and OSC talks at port 12000 
 myRemoteLocation = new NetAddress("18.85.58.180",12000);
  
  color_count = new int[light_strings*lights_per_string];
  for(int i=0; i< light_strings*lights_per_string; i++)
    color_count[i] = i%1000;

}



void draw(){
    OscMessage myMessage = new OscMessage("/Computer1");
  
  for(int i=0; i<light_strings; i++)
  {
    for(int j=0; j<lights_per_string; j++)
    {
      Color tmp = new Color(Color.HSBtoRGB(color_count[j+i*lights_per_string]/1000.0f,1,1));
      int pixelColor = tmp.getRGB();
      
      myMessage.add(pixelColor);
      color_count[j+i*lights_per_string] = (color_count[j+i*lights_per_string] +20)%1000;
    }
    
  }
  
  
  oscP5.send(myMessage, myRemoteLocation);  // Send to our Office
  
  
}
