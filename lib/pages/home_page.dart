import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lighttodark/main.dart';
import 'package:lighttodark/models/catalog.dart';
import 'package:lighttodark/widgets/drawer.dart';
import 'package:lighttodark/widgets/item_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async{
    await Future.delayed(Duration(seconds: 3));
    final catalogJson = await rootBundle.loadString('assets/files/catalog.json');
    final decodeData = jsonDecode(catalogJson);
    var productsData = decodeData['products'];
    CatalogModel.Items = List.from(productsData).map<Item>((item)=>Item.fromMap(item)).toList();
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if(CatalogModel.Items.isNotEmpty)
                CatalogList().expand()
              else
                 CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      )
    );
  }
}

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Catalog App',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.blueGrey),),
        Text('Trending Products',style: TextStyle(fontSize: 15),)
      ],
    );
  }
}
class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.Items.length,
        itemBuilder: (context,index){
        final catalog = CatalogModel.Items[index];
        return CatalogItem(catalog: catalog,);
        });
  }
}

class CatalogItem extends StatelessWidget{
  final Item catalog;
  const CatalogItem({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          CatalogImage(image: catalog.image),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              catalog.name.text.lg.white.bold.make(),
              catalog.desc.text.coolGray700.make(),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: EdgeInsets.zero,
                children: [
                  "\$${catalog.price}".text.bold.xl.make(),
                  ElevatedButton( onPressed: (){}, style: ButtonStyle(
                    shape: MaterialStateProperty.all(StadiumBorder()),
                    backgroundColor: MaterialStateProperty.all(Vx.coolGray700)
                  ),child: "Buy".text.bold.make(),
                  )
                ],
              ).pOnly(right: 8.0),
            ],
          ))
        ],
      )
    ).white.rounded.square(150).make().py16();
  }
}

class CatalogImage extends StatelessWidget {
  final String image;
  const CatalogImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.network(image).box.rounded.coolGray100.p8.make().p16().w40(context);
  }
}



