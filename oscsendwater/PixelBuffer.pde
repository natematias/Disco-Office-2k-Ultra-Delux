class PixelBuffer {
  Color[][] colors;
  int width;
  int height;
  
  PixelBuffer(int width, int height) {
    this.colors = new Color[width][height];
    this.width=width;
    this.height=height;
  }
  
  void set(Color clr, int x, int y){
    this.colors[x][y]=clr;
  }
  
  void loadFromScreen() {
    loadPixels();
    for(int i=0; i<width; i++){
      for(int j=0; j<height; j++) {
        color sp = pixels[j*width+i];
        this.set(new Color(red(sp)/255.0, green(sp)/255.0, blue(sp)/255.0), i, j);
      }
    }
  }
  
  void serialize( OscMessage msg ) {
    for(int i=0; i<this.width; i++){
      for(int j=0; j<this.height; j++) {
        Color clr = this.colors[i][j];
        msg.add( clr.getRGB() );
      }
    }
  }
}