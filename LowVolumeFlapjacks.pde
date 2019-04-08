// Pancake Drums inspired by Vulfpeck's Birds of a Feather
// https://www.youtube.com/watch?v=WQm4R0LM2mE

// Allows us to play our audio
import ddf.minim.*;

// Initialize audio lib
Minim minim;

// Allows us to work with bird image data
JSONArray json;
import http.requests.*;
PImage birdImage;

// Create instance for each drum file
AudioSample kick;
AudioSample snare;
AudioSample hihat;
AudioSample tom;

void setup() {
  // Set http agent
  System.setProperty("http.agent", "Chrome");

  size(1000, 1000);
  
  minim = new Minim(this);
  
  // Buffer is set to 150 for less input delay
  kick = minim.loadSample("kick.wav", 150);
  snare = minim.loadSample("snare.mp3", 150);
  hihat = minim.loadSample("hihat.mp3", 150);
  tom = minim.loadSample("tom.wav", 150);
  
  // Get our initial bird image
  callBird();
}

void draw() {
  background(255, 255, 255);
  image(birdImage, 300, 300);
}

// Grab a random bird from the API
void callBird() {
  clear();
  GetRequest get = new GetRequest("http://shibe.online/api/shibes?count=[1-100]&urls=[true/false]&httpsUrls=[true/false]");
  get.send();
  JSONArray json = parseJSONArray(get.getContent());
  println(json);
  birdImage = loadImage("https://cdn.shibe.online/shibes/" + json.getString(0) + ".jpg", "jpg");
  delay(1000);
}
 
// Trigger our drum hits
void keyPressed() {
  // Kick
  if (key == CODED && keyCode == UP) {
    kick.trigger();
    callBird();
  }
  
  // Snare
  if (key == CODED && keyCode == DOWN) {
    snare.trigger();
    callBird();
  }
  
  // Hihat
  if (key == CODED && keyCode == LEFT) {
    hihat.trigger();      
    callBird();
  }
  
  // Tom
  if (key == CODED && keyCode == RIGHT) {
    tom.trigger();
    callBird();
  }
}  
