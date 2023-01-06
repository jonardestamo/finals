import 'package:flutter/material.dart';
import 'package:sqflite_demo/database_connector/dbHelper.dart';



import 'product.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDetails = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    txtName.text = product.name;
    txtDetails = product.details as TextEditingController;
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Detail : ${product.name}",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              ),
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  Widget buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
      ),
    );
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Product Name : ",
      ),
      controller: txtName,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Product Description : ",
      ),
      controller: txtDetails,
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Product Price : ",
      ),
      controller: txtUnitPrice,
    );
  }

  void selectProcess(Options options) async {
    //print(value);
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(
            id: product.id,
            name: txtName.text,
            details: txtDetails.text,
            unitPrice: double.tryParse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}