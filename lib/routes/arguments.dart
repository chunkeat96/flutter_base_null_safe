enum NavigateType {
  search,
  category
}

class ProductDetailsArguments {
  final String? productId;

  ProductDetailsArguments({this.productId});
}

class ProductListArguments {
  final NavigateType? navigateType;
  final String? prdCategoryId;
  final String? type;

  ProductListArguments({this.navigateType, this.prdCategoryId, this.type});
}
