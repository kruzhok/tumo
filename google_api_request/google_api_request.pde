import websockets.*;
import http.requests.*;

WebsocketServer socket;

String message = "";
String previousMessage = "";

JSONObject json;

String token = "вставьте токен";
String cx = "вставьте cx";
String url = "https://www.googleapis.com/customsearch/v1?searchType=image&key=" + token + "&cx=" + cx + "&q=";
String query;

PImage church;

void setup() { 
  size(200, 200); 
  background(50); 
  fill(200);
  
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  json = loadJSONObject("data.json");
} 

void draw() {
  try {
    query = json.getString(message);
    if (query != null && !previousMessage.contains(message)) {
      println("Запрос: ", query);
      church = loadImage(getImageSrc(query + "+church"));
      previousMessage = message;
      message = "";
    }
  } catch (Exception e) {
     println("Ошибка");
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