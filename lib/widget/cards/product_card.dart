import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_test/pattern.dart';
import '/model/product.dart';
import '/widget/k_text.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: product.id ?? "www.google.com",
              // width: 320,
              color: Colors.black,
              style: TextStyle(
                fontFamily: "Lemonada",
                color: AppPattern.secondaryColor!,
              ),
            ),
            KText(
              formatUrl(product.id ?? "www.google.com",),
              color: Colors.black.withOpacity(.7),
            )
          ],
        ),
      ),
    );
  }

  String formatUrl(String url){
    if(url.startsWith("http")) url = url.replaceAll("http://", "");
    if(url.startsWith("https")) url = url.replaceAll("https://", "");
    if(url.endsWith("/")) url = url.replaceAll("/", "");
    return url;
  }
}
