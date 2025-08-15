import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PdfTable {
  static pw.Widget genrate(
      {required List<List<String>> data,
      double? fontSize,
      required List<String> titles,
      PdfColor? themeColor}) {
    return pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey, width: 1),
        children: [
              pw.TableRow(
                  children: titles.map((value) {
                return pw.Container(
                    color: themeColor,
                    child: pw.Text(
                      value,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                          fontSize: fontSize ?? 9),
                    ));
              }).toList())
            ] +
            data.map((row) {
              return pw.TableRow(
                  children: row.map((value) {
                return pw.Container(
                    child: pw.Text(
                  value,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      color: PdfColors.black,
                      fontSize: fontSize ?? 8),
                ));
              }).toList());
            }).toList());
  }
}
