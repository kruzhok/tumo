import themidibus.*; //Import the library
import websockets.*;
import http.requests.*;
import gifAnimation.*;

WebsocketServer socket;

String message = "";
String previousMessage = "";

JSONObject json;
MidiBus myBus; // The MidiBus
int bob = 0;

String token = "AIzaSyDDi29qYd9OgBBCRFKOImeHlXwEwAPAueY";
String cx = "011138245924366795803:ttyav6fhny0";
String url = "https://www.googleapis.com/customsearch/v1?searchType=image&key=" + token + "&cx=" + cx + "&q=";
String query;

PImage church;
PImage musea;
PImage map;
PImage water;

PFont font;

Gif earth;

void setup() { 
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
                
  myBus = new MidiBus(this, "Playtron", "Playtron"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  imageMode(CENTER);
  size(700, 500); 
  background(50); 
  fill(200);
  
  font = createFont("Arial Black", 48);
  textFont(font);
  textMode(CENTER);
  textAlign(CENTER);
  
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  json = loadJSONObject("data.json");
  
  //earth = Gif.getPImages(this, "giphy.gif");
  earth = new Gif(this, "giphy.gif");
} 

void draw() {
  try {
    query = json.getString(message);
    if (query != null && !previousMessage.contains(message)) {
      println("Запрос: ", query);
      try {
        church = loadImage(getImageSrc(query + "+church"));
      } catch (Exception e) {
        church = loadImage("https://www.property118.com/wp-content/uploads/2016/08/vmRSZbWkIT.png");
      }
      try {
        water = loadImage(getImageSrc(query + "+water"));
      } catch (Exception e) {
        water = loadImage("https://www.property118.com/wp-content/uploads/2016/08/vmRSZbWkIT.png");
      }
      try {
        musea = loadImage(getImageSrc(query + "+musea"));
      } catch (Exception e) {
        musea = loadImage("https://www.property118.com/wp-content/uploads/2016/08/vmRSZbWkIT.png");
      }
      try {
        map = loadImage(getImageSrc(query + "+map"));
      } catch (Exception e) {
        map = loadImage("https://www.property118.com/wp-content/uploads/2016/08/vmRSZbWkIT.png");
      }
      
      previousMessage = message;
      message = "";
    }
  } catch (Exception e) {
     println("Ошибка");
  }

  if (bob==(37)){
    image(musea, width/2, height/2, 600, 600);
  //background(0, 255, 0);
  
  
  }
  else if(bob == 0){
    background(0, 0, 0);
    earth.play();
    image(earth, width / 2, height / 2);
  }
  else if(bob ==47) {
    image(map, width / 2, height / 2, 600, 600);
    //background(255, 0, 0);
  }
  else if(bob == 51){
    image(water, width/2, height/2, 600, 600);
    //background(0, 150, 23);
  }
   if (bob==(37)){
    image(musea, width/2, height/2, 600, 600);
  //background(0, 255, 0);
  
  
  }
  else if(bob == 43){
    image(church, width/2, height/2, 600, 600);
    //background(255, 255, 0);
  }
  
}

void webSocketServerEvent(String msg){
  message = trim(msg).toLowerCase();
  println("Message: " + msg);
}

String getImageSrc(String query) {
  String response;
  String imageURL;
  GetRequest get = new GetRequest(url + query);
  get.send(); // Программа будет ждать пока запрос выполнится
  try {
    response = get.getContent();
    JSONObject data = parseJSONObject(response);
    JSONArray items = data.getJSONArray("items");
    int itemId = int(random(items.size()));
    JSONObject item = items.getJSONObject(itemId);
    imageURL = item.getString("link");
  } catch (Exception e) {
    imageURL = "https://www.hsjaa.com/images/joomlart/demo/default.jpg";
  }
  println("Адрес картинки: " + imageURL);
  return imageURL;
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  bob=0;
 
  println("Off");
  println("Pitch: " + pitch);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  bob = pitch;

  println("On");
  println("Pitch: " + pitch);
}