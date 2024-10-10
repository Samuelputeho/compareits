import 'package:flutter/material.dart';

import '../common/generic_category_page.dart';

class PicknpayCategoryPage extends StatelessWidget {
  PicknpayCategoryPage({Key? key}) : super(key: key);

  // List of category names
  @override
  Widget build(BuildContext context) {
    return GenericCategoryPage(storeName: 'PickNPay');
  }
}
