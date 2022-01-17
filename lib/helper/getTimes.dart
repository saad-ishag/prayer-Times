import 'location.dart';
import 'network.dart';
import 'package:navigation_demo_starter/city.dart';

const String kPTimesURL = 'https://api.pray.zone/v2/times/today.json';
const apiKey = '8b295ab99f30f8851e193dfdee049427';

class GetTimes {
  Location location = Location();

  Future<dynamic> locationPrayerTimes() async {
    await location.getCurrentLocation();

    Network network = Network(
        url:
            '$kPTimesURL?longitude=${location.longitude}&latitude=${location.latitude}');
    var pTimes = await network.getData();
    return pTimes;
  }

  Future cityPrayerTimes(String cityName) async {
    Network network = Network(url: '$kPTimesURL?city=$cityName');
    var pTimes = await network.getData();
    return pTimes;
  }

  Future<List<City>> getSuggestions(String query ) async {
    Network network = Network(url: 'https://api.openweathermap.org/geo/1.0/direct?q=$query&limit=3&appid=8b295ab99f30f8851e193dfdee049427');
    final List cityNames = await network.getData();

    return cityNames.map((json)=> City.fromJson(json)).where((city) {

        final  queryLower = query.toLowerCase();
        final  cityLower = city.name.toLowerCase();

        return cityLower.startsWith(queryLower);

      }).toList();

    }

  }

