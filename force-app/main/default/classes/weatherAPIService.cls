//Test 1
//Test 2
//Test 3
//Test 4

public class weatherAPIService {
    public class WeatherResponse{
        public string city;
        public string temperature;
        public string condition;
    }
    public static WeatherResponse getWeather(string city){
        string apiKey = 'b1a81a7817b441ca8cf55041251607';
        String endpoint = 'https://api.weatherapi.com/v1/current.json?key=' + apiKey + '&q=' +EncodingUtil.urlEncode(city, 'UTF-8');
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
        if(res.getStatusCode()==200){
          map<string,Object> jsonMap =  (map<string,Object>)JSON.deserializeUntyped(res.getBody());
          map<string,Object> location =  (map<string,Object>)jsonMap.get('location');
          map<string,Object> current =  (map<string,Object>)jsonMap.get('current');
          map<string,Object> condition =  (map<string,Object>)current.get('condition');
            
          WeatherResponse result = new WeatherResponse();
          result.city=(string) location.get('name');
          result.temperature = String.valueOf((Decimal) current.get('temp_c'));
          result.condition = (String) condition.get('text');
          return result;
        }else{
            system.debug('Error==>'+res.getBody());
            return null;
        }
        
    }
}