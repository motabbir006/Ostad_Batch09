import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'product_controller.dart';
import 'package:product_list_api/widget/product_card.dart';
import 'widget/product_card.dart';

class crudApi extends StatefulWidget {
  @override
  State<crudApi> createState() => _crudApiState();
}

class _crudApiState extends State<crudApi> {
  final ProductController productController = ProductController();
  void productDialog({String ? id, String ? name,int ? qty,String ? img,int ? unitPrice, int ? totalPrice}) {


    TextEditingController productNameController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productUnitController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name ?? '';
    productQtyController.text =qty.toString() ?? '';
    productImageController.text= img ?? '';
    productUnitController.text = unitPrice.toString() ?? '';
    productTotalPriceController.text = totalPrice.toString() ?? '';

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(id==null ? 'Add product' : 'Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: productImageController,
                decoration: InputDecoration(labelText: 'Product Image'),
              ),
              TextField(
                controller: productQtyController,
                decoration: InputDecoration(labelText: 'Product Qty'),
              ),
              TextField(
                controller: productUnitController,
                decoration:
                InputDecoration(labelText: 'Product Unit price'),
              ),
              TextField(
                controller: productTotalPriceController,
                decoration: InputDecoration(labelText: 'Total Price'),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Close')),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {


                      if(id== null){
                        productController.createProduct(
                            productNameController.text,
                            productImageController.text,
                            int.parse(productQtyController.text),
                            int.parse(productUnitController.text),
                            int.parse(productTotalPriceController.text));
                      }
                      else{
                        productController.updateProduct(
                            id,
                            productNameController.text,
                            productImageController.text,
                            int.parse(productQtyController.text),
                            int.parse(productUnitController.text),
                            int.parse(productTotalPriceController.text));
                      }
                      fetchData();
                      Navigator.pop(context);
                      setState(() {
                      });

                    },
                    child: Text(id==null ? 'Add product' : 'Update Product'),)
                ],
              )
            ],
          ),
        ));
  }

  Future<void> fetchData() async {
    await productController.fetchProducts();
    print(productController.products.length);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product',
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7),
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          var product = productController.products[index];
          return ProductCard(
            product: product,
            onEdit: () => productDialog(
              id: product.sId,
              name: product.productName,
              img: product.img,
              qty: product.qty,
              unitPrice: product.unitPrice,
              totalPrice: product.totalPrice,

            ),
            onDelete: (){
              productController.deleteProducts(product.sId.toString()).then((value) {
                if (value) {
                  setState(() {
                    fetchData();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Product deleted"),
                      duration: Duration(seconds: 2),

                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Something wrong try again"),
                      duration: Duration(seconds: 2),

                    ),
                  );
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}