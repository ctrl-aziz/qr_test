import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:qr_test/pattern.dart';
import 'package:qr_test/widget/k_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/product.dart';
import 'provider/product_provider.dart';
import 'qr_reader_page.dart';
import 'utilities/navigator_helper.dart';
import 'widget/cards/product_card.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Test',
      debugShowCheckedModeBanner: false,
      theme: AppPattern.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(productProvider);
    final products = ref.read<ProductProvider>(productProvider.notifier).products;
    return Scaffold(
      appBar: AppBar(
        title: KText(
          "Qr app for Test",
          color: Colors.black.withOpacity(.6),
        ),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    _launchUrl(products[i].id ?? "www.google.com", context);
                  },
                  child: ProductCard(
                    product: products[i],
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorHelper.push(
            context,
            QrReaderPage(
              onResult: (val) {
                ref.read<ProductProvider>(productProvider.notifier).setLoading();
                _checkProduct(context, val);
                ref.read<ProductProvider>(productProvider.notifier).getProducts();
              },
            ),
          );
        },
        child: const Icon(Icons.qr_code),
      ),
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    try{
      !await launchUrl(Uri.parse(url));
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: KText("Could not launch $url"),
        ),
      );
      // throw 'Could not launch $url';
    }
  }

  void _addProduct(Product product) {
    Box<Product> box = Hive.box<Product>('products');

    box.put(product.id, product);
  }

  void _checkProduct(BuildContext context, String? productID) async {
    if (productID == null) return;
    Box<Product> box = Hive.box<Product>('products');

    dynamic product = box.get(productID);

    if (product == null) {
      _addProduct(
        Product(
          id: productID,
          name: "",
          price: 0,
          count: 1,
        ),
      );
    } else {
      _addProduct(product);
    }
  }
}
