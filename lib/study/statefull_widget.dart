
import 'package:flutter/material.dart';


/// 根据用户状态来改变widget状态，类似Compose重组。
/// 改变widget核心在于StatefulWidgets和State
/// 在 Flutter 中，这两种类型的对象具有不同的生命周期。
/// Widget 是临时对象，用于构造应用当前状态的展示。
/// 而 State 对象在调用 build() 之间是持久的，以此来存储信息。
/// state可以类比Compose中的mutableState(*)
/// 通常来说:
/// 如果是数据改变，让父widget来管理state更合适
/// 如果是UI改变，让子widget来管理state更合适
/// 此处的示例是父widget来管理state，子widget通过回调来传递点击事件到父widget

void main() {
  runApp(
    const MaterialApp(
      title: "Shopping App",
      home: ShoppingList(
        products: [
          Product(name: "Eggs"),
          Product(name: "Flour"),
          Product(name: "Chocolate chips")
        ],
      ),
    )
  );
}

class Product {
  final String name;

  const Product({required this.name});
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  // key类似于RecycleView中的DiffUtils, 来匹配其他的widget。
  ShoppingListItem({
    Key? key,
    required this.product,
    required this.inCart,
    required this.onCartChanged
  }) : super(key: ObjectKey(product));

  Color _getColor(BuildContext context) =>
      inCart ? Colors.black54 : Theme.of(context).primaryColor;

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) {
      return null;
    }

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  final List<Product> products;
  const ShoppingList({
    required this.products,
    Key? key
  }) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCardChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) => ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCardChanged,
        )).toList(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

