import 'package:flutter/material.dart';

/// A placeholder class that represents an entity or model.
class PhotoPair {
  const PhotoPair(
      this.photo1, this.photo2, this.photo1value, this.photo2value, this.name);

  final AssetImage photo1;
  final AssetImage photo2;
  final int photo1value;
  final int photo2value;
  final String name;
}
