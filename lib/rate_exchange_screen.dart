import 'package:flutter/material.dart';
import 'package:flutter_task/services/get_exchange.dart';

class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  var data = [];
  bool isLoading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    data = await NetworkCall().getExchangeRates().catchError((e) {
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
          title: const Text('Currency rates'),
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
                        leading: CircleAvatar(
                            child: Center(
                          child: Text(data[index].name.toString()[0]),
                        )),
                        title: Text(data[index].name),
                        trailing: Text(
                          "\$ " + data[index].value,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      );
                    })),
      ),
    );
  }
}
