import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfViewerPage extends StatelessWidget {
  final PDFDocument document;
  final String nameBook;

  const PdfViewerPage({super.key, required this.document, required this.nameBook});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameBook),
      ),
      body: PDFViewer(
        document: document,
        lazyLoad: false,
        scrollDirection: Axis.horizontal,
        showPicker: false,
        showIndicator: false,
        showNavigation: false,
      ),
    );
  }
}