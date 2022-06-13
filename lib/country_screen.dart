import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Country list'),
          centerTitle: true,
        ),
        body: isLoading
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
                        title: Text(data[index].name),
                        trailing: Text(data[index].value),
                      );
                    })),
      ),
    );
  }
}
