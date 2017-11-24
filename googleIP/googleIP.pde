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

PImage defaultImage;
PImage church;
PImage musea;
PImage map;
PImage water;

Gif myAnimation;

void setup() { 
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
                
  myBus = new MidiBus(this, "Playtron", "Playtron"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  imageMode(CENTER);
  size(800, 800); 
  background(50); 
  fill(200);
  
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  json = loadJSONObject("data.json");

  myAnimation = new Gif(this, "giphy.gif");
  myAnimation.play();
  imageMode(CENTER);
  
  defaultImage = loadImage("default.png");
  church = defaultImage;
  musea = defaultImage;
  map = defaultImage;
  water = defaultImage;
} 

void draw() {
  try {
    query = json.getString(message);
    if (query != null && !previousMessage.contains(message)) {
      println("Запрос: ", query);
      try {
        church = loadImage(getImageSrc(query + "+church"));
      } catch (Exception e) {
        church = defaultImage;
      }
      try {
        water = loadImage(getImageSrc(query + "+water"));
      } catch (Exception e) {
        water = defaultImage;
      }
      try{
        musea = loadImage(getImageSrc(query + "+musea"));
      } catch (Exception e) {
        musea = defaultImage;
      }
      try {
        map = loadImage(getImageSrc(query + "+map"));
      }catch (Exception e) {
        map = defaultImage;
      }
      
      previousMessage = message;
      message = "";
    }
  } catch (Exception e) {
     println("Ошибка");
  }
  
  

    if (bob==(37)){
      try {
        image(musea, width/2, height/2, 600, 600);
      } catch (Exception e) {
        image(defaultImage, width/2, height/2, 600, 600);
      }
    }
    else if(bob == 0){
      background(0, 0, 0);
      myAnimation.play();
      image(myAnimation, width/2, height/2);
    }
    else if(bob ==47) {
      try {
        image(map, width/2, height/2, 600, 600);
      } catch (Exception e) {
        image(defaultImage, width/2, height/2, 600, 600);
      }
    }
    else if(bob == 51){
      try {
        image(water, width/2, height/2, 600, 600);
      } catch (Exception e) {
        image(defaultImage, width/2, height/2, 600, 600);
      }
    }
    else if(bob == 43){
      try {
        image(church, width/2, height/2, 600, 600);
      } catch (Exception e) {
        image(defaultImage, width/2, height/2, 600, 600);
      }
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
 
  println("Pitch:" + pitch);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  bob = pitch;

  println("Pitch:" + pitch);
}