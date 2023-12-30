<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# UI Package

<!--[![Pub](https://img.shields.io/pub/v/font_awesome_search.svg)](https://pub.dev/packages/font_awesome_search)-->

Provide a search function for [ui_package](https://pub.dev/packages/ui_package) package using the same Algolia search engine that powers the FontAwesome Icon Gallery

This function call graphql API from https://x-brymo/github.com. For more information about the API, please visit
#
!! This package doesn't support custom icons yet, you can only search for free icons !!

## Installation
```yaml
dependencies:
  ui_package: 
  ui_package: any
```

## Usage

```dart
import 'package:ui_package/ui_package.dart';
```

## Important Notice

To make this package work you need to disables icon tree shaking. This means unused
icons will not be automatically removed and thus make the overall app size
larger. You may need to pass --no-tree-shake-icons to the flutter build command for it
to complete successfully.

Example:

```
flutter build apk --no-tree-shake-icons
```
flutter pub get
```
flutter pub add ui_package
```

