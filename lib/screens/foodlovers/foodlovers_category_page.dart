import 'package:flutter/material.dart';

import '../common/generic_category_page.dart';

class FoodLoversCategoryPage extends StatelessWidget {
  FoodLoversCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericCategoryPage(storeName: 'FoodLovers');
  }
}
