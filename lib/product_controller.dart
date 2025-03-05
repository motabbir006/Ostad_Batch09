import 'dart:convert';
import 'package:product_list_api/utils/urls.dart';
import 'package:http/http.dart' as http;

import 'model/product_card.dart';


class ProductController {
  List<Data> products = [];
  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      productModel model = productModel.fromJson(data);
      products = model.data ?? [];
    }
  }

  Future<void> createProduct(
      String name, String img, int qty, int price, int totalPrice) async {
    final responce = await http.post(Uri.parse(Urls.createProduct),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice
        }));

    print(responce.statusCode);

    if (responce.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<void> updateProduct(String id, String name, String img, int qty,
      int price, int totalPrice) async {
    final responce = await http.post(Uri.parse(Urls.updateProduct(id)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice
        }));

    print(responce.statusCode);

    if (responce.statusCode == 201) {
      fetchProducts();
    }
  }

  Future<bool> deleteProducts(String id) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(id)));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
