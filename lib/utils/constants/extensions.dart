import 'package:flutter/material.dart';

//! The use of Sizedbox is set to 10.ph or 10.pw, for example

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}
