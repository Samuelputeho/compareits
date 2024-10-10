import 'package:flutter/material.dart';

import '../common/generic_category_page.dart';

class CheckersCategoryPage extends StatelessWidget {
  CheckersCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericCategoryPage(storeName: 'Checkers');
  }
}
