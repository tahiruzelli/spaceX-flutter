import 'package:spacex/services/urls.dart';

import 'rest_connector.dart';

class FetchData {
  getLastFly() async {
    var response = await RestConnector(
      domain + latesFly,
      requestType: "GET",
      data: '',
    ).getData();
    return response;
  }
}
