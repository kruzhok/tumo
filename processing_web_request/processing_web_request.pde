import processing.net.*;
import processing.sound.*;
SoundFile file;

Client c; 
String data;
String token = "BQDtU2Ra6GmuhXHVDh8zD0cGoeI0D7cozY00_z2FbVdMGJ6yNjk7GAIAusOWvufWGfdUMyP5OtORIrQl1HuupdSE3PoNCdJZ7rhLfR54Xf55wLKPP8VAvLOszUZNjJczBnTX3eI2iQ";

void setup() { 
  size(200, 200); 
  background(50); 
  fill(200);
  c = new Client(this, "https://api.spotify.com/v1/audio-features/06AKEBrKUckW0KREUWRnvT", 80);  // Connect to server on port 80 
  c.write("GET / HTTP/1.0\n");  // Use the HTTP "GET" command to ask for a webpage
  c.write("Host: my_domain_name.com\n\n"); // Be polite and say who we are
} 

void draw() {
  if (c.available() > 0) {    // If there's incoming data from the client...
    data += c.readString();   // ...then grab it and print it 
    println(data); 
  } 
}