import 'dart:convert';

import 'dart:developer';

import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkCall {
  Future<List> getExchangeRates() async {
    var result = [];
    try {
      final response = await http
          .get(
            Uri.parse(
                "https://api.apilayer.com/exchangerates_data/latest?&base=USD&apikey=dKVcuwxdT5jZGcfbThqhuv9H9FMybjHs"),
          )
          .timeout(const Duration(seconds: 30));
      log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);

      // log(message)
      if (response.statusCode == 200) {
        var data = json['rates'] as Map;
        // log(jsonEncode(data));
        var fetchedList = data.entries
            .map((e) => Currency(name: e.key, value: e.value.toString()))
            .toList();
        // var fetchedList = List<ExchangeRatesModelRates>.from(data['rates']
        //     .map((obj) => ExchangeRatesModelRates.fromJson(obj))).toList();
        log(fetchedList[1].value.toString());
        return result = fetchedList;
        // Fluttertoast.showToast(msg: 'Order placed Successfully!');

      } else {
        return result = [];
        // Fluttertoast.showToast(msg: json['Message']);
      }
      // result = json['status'];

      // return result;
    } on SocketException catch (error) {
      // Fluttertoast.showToast(msg: "Please connect to internet!");
      print(error);
    } catch (error) {
      print(error);
      rethrow;
    }
    return result;
  }
}

class Currency {
  Currency({this.name, this.value});
  String? name;
  String? value;
}
