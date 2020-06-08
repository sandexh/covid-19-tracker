import 'dart:convert';
import 'package:http/http.dart' as http;
class NepalData{

  int total_positive;
  int negative;
  int total_tested;
  int deaths;
  int recovered;
  int isolated;
  int quarantined;

  NepalData({
    this.negative,
    this.deaths,
    this.isolated,
    this.quarantined,
    this.recovered,
    this.total_positive,
    this.total_tested,
  });
  factory NepalData.formJson(Map<String, dynamic> json){
    return NepalData(
      negative: json["tested_negative"],
      total_positive: json["tested_positive"],
      total_tested: json["tested_total"],
      recovered: json["recovered"],
      quarantined: json["quarantined"],
      isolated: json["in_isolation"],
      deaths: json["deaths"],
    );
  }
}

class WorldData{
  int total;
  int deaths;
  int recovered;
  WorldData({
    this.deaths,
    this.total,
    this.recovered,
});

  factory WorldData.fromJson(Map<String, dynamic> json){
    return WorldData(
      deaths: json['deaths'],
      total: json["cases"],
      recovered: json["recovered"]
    );
  }
}
Future<WorldData> getWorldData() async{
  final response = await http.get('https://data.nepalcorona.info/api/v1/world');
  if(response.statusCode == 200){
    return WorldData.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed');
  }
}

Future<NepalData> getNepalData() async{
  final response = await http.get('https://nepalcorona.info/api/v1/data/nepal');
  if (response.statusCode == 200){
    return NepalData.formJson(json.decode(response.body));
  } else {
    throw Exception('Failed');
  }
}