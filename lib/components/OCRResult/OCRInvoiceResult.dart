import 'package:eendigodemo/model/InvoiceOCRModel.dart' as IOM;
import 'package:flutter/cupertino.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class OCRInvoiceResult extends StatelessWidget {
  final IOM.InvoiceOcrModel? data;
  const OCRInvoiceResult({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubSectionTitle("Invoice Info"),
        InvoiceInfo(context),
        SubSectionTitle("Receiver"),
        Receiver(),
        SubSectionTitle("Vendor"),
        Vendor(),
        SubSectionTitle("Payment"),
        SubSectionTitle("Table"),
        SubSectionTitle("Other"),],
    );
  }

    Widget Vendor() {
    return Visibility(
      visible: true,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 70, 10),
        child: Table(
          columnWidths: {
            0: FixedColumnWidth(250), // Adjust the width of the first column
            1: FixedColumnWidth(750), // Adjust the width of the second column
          },
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Vendor Name',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Vendor Address',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Vendor Phone',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Vendor URL',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget Receiver() {
    return Visibility(
      visible: true,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 70, 10),
        child: Table(
          columnWidths: {
            0: FixedColumnWidth(250), // Adjust the width of the first column
            1: FixedColumnWidth(750), // Adjust the width of the second column
          },
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Receiver Name',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Receiver Address',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Receiver Phone',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Receiver URL',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget InvoiceInfo(BuildContext context) {
    return Visibility(
      visible: true,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 70, 10),
        child: Table(
          columnWidths: {
            0: FixedColumnWidth(250), // Adjust the width of the first column
            1: FixedColumnWidth(750), // Adjust the width of the second column
          },
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Invoice Receipt ID',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('x', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Tax Payer ID',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Customer Number',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Account Number',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Po Number',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Payment Terms',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11', textAlign: TextAlign.left),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Invoice Receipt Date',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Order Date',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Due Date',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('Delivery Date',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text('11',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Padding SubSectionTitle(String title) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 70, 10),
        child: GradientText(title,
            style: (TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            colors: [
              Color.fromARGB(255, 37, 162, 220),
              Color.fromARGB(255, 28, 115, 185),
              Color.fromARGB(255, 59, 67, 127),
            ]));
  }
}