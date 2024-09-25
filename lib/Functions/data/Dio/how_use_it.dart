
import 'package:dio/dio.dart';
import 'package:ui_package/Functions/data/Dio/handler_dio.dart';
class HowUseIt{
void main() async {
  HandlerApiDio api = HandlerApiDio();

  // Example of making a GET request
  try {
    Response response = await api.get('/endpoint'); // Adjust the endpoint as needed
    print('Response data: ${response.data}');
  } catch (e) {
    print('Failed to fetch data: $e');
  }

  // Example of making a POST request
  try {
    Response response = await api.post('/endpoint', data: {'key': 'value'});
    print('Response data: ${response.data}');
  } catch (e) {
    print('Failed to post data: $e');
  }

  // Example of making an UPDATE (PUT) request
  try {
    Response response = await api.update('/endpoint/id', data: {'key': 'new_value'});
    print('Response data: ${response.data}');
  } catch (e) {
    print('Failed to update data: $e');
  }

  // Example of making a DELETE request
  try {
    Response response = await api.delete('/endpoint/id'); // Provide the specific resource ID
    print('Response data: ${response.data}');
  } catch (e) {
    print('Failed to delete data: $e');
  }
}
}