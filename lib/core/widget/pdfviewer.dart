import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pdfx/pdfx.dart';

class AppPdfViewer extends StatefulWidget {
  final String url;
  const AppPdfViewer({super.key, required this.url});
  @override
  State<StatefulWidget> createState() => _AppPdfViewerState();
}

class _AppPdfViewerState extends State<AppPdfViewer> {
  static const int _initialPage = 2;
  PdfControllerPinch? _pdfController;
  @override
  void initState() {
    super.initState();
    fetchFileFromInternet();
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  void fetchFileFromInternet() async {
    Future<PdfDocument> doc;
    if (widget.url.startsWith('http://') || widget.url.startsWith('https://')) {
      var response = await get(Uri.parse(widget.url));
      var bodyData = response.bodyBytes;
      doc = PdfDocument.openData(bodyData);
    } else if (widget.url.contains('/')) {
      doc = PdfDocument.openFile(widget.url);
    } else {
      doc = PdfDocument.openAsset(widget.url);
    }

    _pdfController = PdfControllerPinch(
      document: doc,
      initialPage: _initialPage,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
      ),
      body: _pdfController == null
          ? Center(child: CircularProgressIndicator())
          : PdfViewPinch(
              controller: _pdfController!,
              onDocumentLoaded: (document) {
                setState(() {});
              },
              onPageChanged: (page) {
                setState(() {});
              },
            ),
    );
  }
}
