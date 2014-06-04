
import ddf.minim.*;
import ddf.minim.analysis.*;


Minim       minim;
AudioPlayer song;
BeatDetect beat;
BeatListener bl;
FFT         fft;

void setup()
{
  size(512, 512, P3D);
  
  minim = new Minim(this);
  song = minim.loadFile("We Are.mp3", 1024);
  song.loop();
  
  beat = new BeatDetect(song.bufferSize(),song.sampleRate());
  bl = new BeatListener(beat, song);  

  fft = new FFT( song.bufferSize(), song.sampleRate() );
  beat.setSensitivity(10);  
}

void draw(){
  background(0,0);
  stroke(0,255,0);
  beat.detect(song.mix);
  if(beat.isHat()){
    stroke(255,255,0);
    background(#298689);
  }
  if(beat.isKick()){
    fft.forward(song.mix);
    for(int i = 0; i < fft.specSize(); i+=5){
//      if fft.getBand(i)

        rect(i,height,5,height - fft.getBand(i)*10);
//      line(i+50, height, i+50, height - fft.getBand(i)*50);
    }
  }
  
  if(beat.isKick()){
    stroke(255,0,0);
    for(int i = 0; i < song.bufferSize() - 1; i++){
      float x1 = map( i, 0, song.bufferSize(), 0, width );
      float x2 = map( i+1, 0, song.bufferSize(), 0, width );
      line( x1, 45 + song.left.get(i)*50, x2, 50 + song.left.get(i+1)*50 );
      line( x1, 145 + song.right.get(i)*50, x2, 150 + song.right.get(i+1)*50 );
    }
  }
  
  
  for(int i = 0; i < song.bufferSize() - 1; i++){
    float x1 = map( i, 0, song.bufferSize(), 0, width );
    float x2 = map( i+1, 0, song.bufferSize(), 0, width );
    line( x1, 50 + song.left.get(i)*50, x2, 50 + song.left.get(i+1)*50 );
    line( x1, 150 + song.right.get(i)*50, x2, 150 + song.right.get(i+1)*50 );
  }

  
}
