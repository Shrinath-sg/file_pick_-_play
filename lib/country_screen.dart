import 'package:flutter/material.dart';
import 'package:flutter_task/rate_exchange_screen.dart';
import 'package:flutter_task/services/get_exchange.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  var data = [];
  bool isLoading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    data = await NetworkCall().getCountryList().catchError((e) {
      // setState(() {

      // });
      setState(() {
        isLoading = false;
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // log(data.length.toString());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Country list'),
          centerTitle: true,
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : data.isEmpty
                ? const Center(
                    child: Text('No data'),
                  )
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: (() => Navigator.pushNamed(
                            context, ExchangeRateScreen.routeName,
                            arguments: data[index].name.toString())),
                        leading: CircleAvatar(
                            child: Center(
                          child: Text(data[index].name.toString()[0]),
                        )),
                        title:
                            Text(data[index].name + " - " + data[index].value),

                        // trailing:
                      );
                    })),
      ),
    );
  }
}
