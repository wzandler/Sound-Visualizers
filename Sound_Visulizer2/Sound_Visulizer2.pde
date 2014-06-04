
import ddf.minim.*;
import ddf.minim.analysis.*;


Minim       minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
FFT         fft;

int centX;
int centY;
float lastXL, lastYL,lastXR,lastYR;

void setup(){
  size(512, 512, P3D);
  
  minim = new Minim(this);
  song = minim.loadFile("Hold.mp3", 512);
  song.loop();
  
  beat = new BeatDetect(song.bufferSize(),song.sampleRate());
  bl = new BeatListener(beat, song);  

  fft = new FFT( song.bufferSize(), song.sampleRate() );
  beat.setSensitivity(10);  
  print( song.bufferSize());
  
  centX = width/2;
  centY = height/2;
  lastXL = 0;
  lastYL = 0;
  lastXR = 0;
  lastYR = 0;
}

void draw(){
  background(0);
  stroke(255);
  beat.detect(song.mix);
  if(beat.isHat()){
//    stroke(255,255,0);
//    background(#298689);
  }
  if(beat.isSnare()){
//     fill(255,255,0);
//     ellipse(centX,centY,35,35);
  }
  fill(255,0,0);
  beginShape();
  for(int i = 0; i < song.bufferSize() - 1; i++){
    int radiusR = 155;
    float angle = map(i,0,song.bufferSize(),0,360);
    float xR = centX + ((radiusR + song.right.get(i)*50) * cos(radians(angle)));
    float yR = centY + ((radiusR + song.right.get(i)*50) * sin(radians(angle)));
    vertex(xR,yR);  
  }
  endShape();
 
  


  fill(0,255,0);
  beginShape();
  for(int j = 0; j < song.bufferSize() - 1; j++){
      int radiusL = 125;
      float angle = map(j,0,song.bufferSize(),0,360);
      float xL = centX + ((radiusL + song.left.get(j)*50) * cos(radians(angle)));
      float yL = centY + ((radiusL + song.left.get(j)*50) * sin(radians(angle)));
      vertex(xL,yL);
  }
  endShape();

  
}
