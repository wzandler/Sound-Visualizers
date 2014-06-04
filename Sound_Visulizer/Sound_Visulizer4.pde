
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
  song = minim.loadFile("Sheep.mp3", 512);
  song.loop();
  
  beat = new BeatDetect(song.bufferSize(),song.sampleRate());
  bl = new BeatListener(beat, song);  

  fft = new FFT( song.bufferSize(), song.sampleRate() );
  beat.setSensitivity(10);  
  print(song.bufferSize());
  
  centX = width/2;
  centY = height/2;
  lastXL = 0;
  lastYL = 0;
  lastXR = 0;
  lastYR = 0;
  
//  strokeWeight(3);
}

void draw(){
  background(25);
  fft.forward(song.mix);
//  for(int j = 0; j < fft.specSize(); j++){
    stroke(255);
    line(mouseX, height, mouseX, height - fft.getBand(mouseX)*8);
    println(mouseX);
//  }
//  beat.detect(song.mix);
//  if(beat.isHat()){
////    stroke(255,255,0);
////    background(#298689);
//  }
//  if(beat.isSnare()){
////     fill(255,255,0);
////     ellipse(centX,centY,35,35);
//  }

  for(int i = 0; i < song.bufferSize() - 1; i++){
    float radiusL = fft.getBand(9)*8;
    float radiusR = fft.getBand(9)*10;
    float angle = map(i,0,song.bufferSize(),0,360);
    float xR = centX + ((radiusR + song.right.get(i)*50) * cos(radians(angle)));
    float yR = centY + ((radiusR + song.right.get(i)*50) * sin(radians(angle)));
    float xL = centX + ((radiusL + song.left.get(i)*50) * cos(radians(angle)));
    float yL = centY + ((radiusL + song.left.get(i)*50) * sin(radians(angle)));
    
    stroke(0,255,0);
    fill(0,255,0);
    point(xL,yL);
//    if(i%5 == 0) line(centX,centY,xL,yL);
    ellipse(xL,yL,2,2);
    
    stroke(255,0,0);
    fill(255,0,0);
    point(xR,yR);
//    if(i%7 == 0) line(centX,centY,xR,yR);
    ellipse(xR,yR,2,2);
  }
  

  
}
