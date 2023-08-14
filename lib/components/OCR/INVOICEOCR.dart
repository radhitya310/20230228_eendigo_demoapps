// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/model/InvoiceOCRModel.dart' as IOM;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:simple_gradient_text/simple_gradient_text.dart';

class InvoiceOCR extends StatefulWidget {
  const InvoiceOCR({Key? key}) : super(key: key);

  @override
  State<InvoiceOCR> createState() => _InvoiceOCRState();
}

class _InvoiceOCRState extends State<InvoiceOCR> {
  IOM.InvoiceOcrModel? iomData;
  bool isLoading = false;
  String _fileName = 'No file chosen';
  String base64String = '';
  File? invoiceFile;
  var fileBytes;

  int invoiceReceiptId = 0;
  int taxPayerId = 0;
  int custNumber = 0;
  int accountNumber = 0;
  int poNumber = 0;
  int paymentTerms = 0;
  int invoiceReceiptDate = 0;
  int orderDate = 0;
  int dueDate = 0;
  int deliveryDate = 0;

  int receiverName = 0;
  int receiverAddress = 0;
  int receiverPhone = 0;
  int receiverUrl = 0;

  int vendorName = 0;
  int vendorUrl = 0;
  int vendorAddress = 0;
  int vendorPhone = 0;

  Future<IOM.InvoiceOcrModel> InvoiceOCRAPI(File _KtpImage) async {
    IOM.InvoiceOcrModel data = IOM.InvoiceOcrModel();
    final Url =
        'https://ocr-invoice---adinsocr-go3voyqswq-et.a.run.app/ocr_invoice';

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    http.MultipartFile file =
        http.MultipartFile.fromBytes('file', fileBytes, filename: _fileName);

    request.files.add(file);
    request.fields['key'] = '';
    request.fields['tenant_code'] = '';
    request.fields['cust_no'] = '';

    final timeout = Duration(seconds: 120);
    final client = http.Client();

    try {
      final response =
          await client.send(request).timeout(timeout, onTimeout: () async {
        client.close();
        print('request timeout');
        throw Exception('request timeout');
      });

      if (response.statusCode == 200) {
        var ujson1 = await utf8.decodeStream(response.stream);
        //var ujson1 = '{\"Invoice Info\":[{\"confidence_label\":99.96412658691406,\"confidence_value\":99.64474487304688,\"label\":\"Invoice Receipt ID\",\"value\":\"IDI_062023_060\"},{\"confidence_label\":\"\",\"confidence_value\":\"\",\"label\":\"Tax Payer ID\",\"value\":\"\"},{\"confidence_label\":\"\",\"confidence_value\":\"\",\"label\":\"Customer Number\",\"value\":\"\"},{\"confidence_label\":\"\",\"confidence_value\":\"\",\"label\":\"Account Number\",\"value\":\"\"},{\"confidence_label\":\"\",\"confidence_value\":\"\",\"label\":\"Po Number\",\"value\":\"\"},{\"confidence_label\":93.83663940429688,\"confidence_value\":93.82340240478516,\"label\":\"Payment Terms\",\"value\":\"30 Days from Invoice Date\"},{\"confidence_label\":99.87003326416016,\"confidence_value\":99.84965515136719,\"label\":\"Invoice Receipt Date\",\"value\":\"28 Jun 2023\"},{\"confidence_label\":\"\",\"confidence_value\":\"\",\"label\":\"Order Date\",\"value\":\"\"},{\"confidence_label\":99.9981918334961,\"confidence_value\":99.72740173339844,\"label\":\"Due Date\",\"value\":\"28 Jul 2023\"},{\"confidence_label\":\"\",\"confidence_value\":\"\",\"label\":\"Delivery Date\",\"value\":\"\"}],\"Other\":[{\"confidence_label\":99.78689575195312,\"confidence_value\":99.62124633789062,\"label\":\"Reference\",\"value\":\"IDI_062023_060\"},{\"confidence_label\":99.77283477783203,\"confidence_value\":99.77278900146484,\"label\":\"Total PPN\",\"value\":\"11%\"},{\"confidence_label\":92.80496978759766,\"confidence_value\":97.87300872802734,\"label\":\"Our Bank Account Details are as follows :\",\"value\":\"Account Name : PT Indonesia Digital Identity Beneficiary Bank : Bank Central Asia Branch : Ancol Jakarta SWIFT Code : CENAIDJA IDR Account No : 1110112222 USD Account No : 1110112222 Terms of Payment : 30 Days from Invoice Date\"},{\"confidence_label\":98.16900634765625,\"confidence_value\":99.9480209350586,\"label\":\"Beneficiary Bank :\",\"value\":\"Bank Central Asia\"},{\"confidence_label\":97.63627624511719,\"confidence_value\":99.82891845703125,\"label\":\"Branch :\",\"value\":\"Ancol Jakarta\"},{\"confidence_label\":98.21536254882812,\"confidence_value\":99.94322967529297,\"label\":\"SWIFT Code :\",\"value\":\"CENAIDJA\"},{\"confidence_label\":98.38832092285156,\"confidence_value\":99.96855926513672,\"label\":\"IDR Account No :\",\"value\":\"1110112222\"},{\"confidence_label\":97.32498168945312,\"confidence_value\":99.96403503417969,\"label\":\"USD Account No :\",\"value\":\"1110112222\"},{\"confidence_label\":91.72125244140625,\"confidence_value\":91.73577117919922,\"label\":\"Head of Finance\",\"value\":\"Mutiara\"},{\"confidence_label\":99.9132080078125,\"confidence_value\":98.96300506591797,\"label\":\"Fax\",\"value\":\"+6221 2598 2531\"}],\"Payment\":[{\"Page\":1,\"info\":[{\"confidence_label\":98.9640121459961,\"confidence_type\":98.98388671875,\"confidence_value\":98.95934295654297,\"label\":\"Total PPN 11%\",\"type\":\"TAX\",\"value\":\"1,100,000.00\"},{\"confidence_label\":99.8738784790039,\"confidence_type\":99.88519287109375,\"confidence_value\":99.86499786376953,\"label\":\"Invoice Total IDR\",\"type\":\"TOTAL\",\"value\":\"11,100,000.00\"}]}],\"Receiver\":[{\"confidence_label\":99.6649169921875,\"confidence_value\":99.63343048095703,\"label\":\"Receiver Name\",\"value\":\"PT Adicipta Inovasi Teknologi\"},{\"confidence_label\":98.63380432128906,\"confidence_value\":98.4005355834961,\"label\":\"Receiver Address\",\"value\":\"PT Adicipta Inovasi Teknologi\\nAttention: Pandu\\nGrha Adlns\\nJI. Kebon Jeruk Raya no. 80, RT.7\/RW.1\\nKel. Kb. Jeruk, Kec. Kb. Jeruk\\nJAKARTA BARAT DKI JAKARTA 11530\\nINDONESIA\"},{\"confidence_label\":\"\",\"confidence_value\":\"\",\"label\":\"Receiver Phone\",\"value\":\"\"},{\"confidence_label\":\"\",\"confidence_value\":\"\",\"label\":\"Receiver URL\",\"value\":\"\"}],\"Table\":[{\"Page\":1,\"info\":[{\"row\":[{\"confidence_label\":79.99758911132812,\"confidence_type\":70.0,\"confidence_value\":99.98863983154297,\"label\":\"Description\",\"type\":\"ITEM\",\"value\":\"VIDA Digital Certificate Issuance\"},{\"confidence_label\":\"\",\"confidence_type\":70.0,\"confidence_value\":0.0,\"label\":\"\",\"type\":\"OTHER\",\"value\":\"\"},{\"confidence_label\":79.99909210205078,\"confidence_type\":70.0,\"confidence_value\":99.9963150024414,\"label\":\"Quantity\",\"type\":\"QUANTITY\",\"value\":\"10,000.00\"},{\"confidence_label\":79.96976470947266,\"confidence_type\":70.0,\"confidence_value\":99.9972915649414,\"label\":\"Unit Price\",\"type\":\"UNIT_PRICE\",\"value\":\"1,000.00\"},{\"confidence_label\":79.99337005615234,\"confidence_type\":70.0,\"confidence_value\":99.99768829345703,\"label\":\"Amount IDR\",\"type\":\"PRICE\",\"value\":\"10,000,000.00\"}]}]}],\"Vendor\":[{\"confidence_label\":99.98970031738281,\"confidence_value\":99.96368408203125,\"label\":\"Vendor Name\",\"value\":\"PT Indonesia Digital\"},{\"confidence_label\":99.99989318847656,\"confidence_value\":99.92208862304688,\"label\":\"Vendor Address\",\"value\":\"PT Indonesia Digital\\nIdentity\\nWTC 1 13th floor,\\nJIJenderal Sudirman No.\\nKav 29-31\\nRT 008\/003, Kuningan,\\nKaret, Setiabudi\\nJAKARTA SELATAN DKI\\nJAKARTA 12920\\nINDONESIA\"},{\"confidence_label\":99.80856323242188,\"confidence_value\":92.6922836303711,\"label\":\"Vendor Phone\",\"value\":\"+6221 2598 3275\"},{\"confidence_label\":99.81934356689453,\"confidence_value\":99.78649139404297,\"label\":\"Vendor URL\",\"value\":\"www.vida.id\"}]}';
        Map<String, dynamic> responses = json.decode(ujson1);
        setState(() {
          data = IOM.InvoiceOcrModel.fromJson(responses);
          invoiceReceiptId = data.invoiceInfo!.indexWhere(
              (element) => element.label!.contains('Invoice Receipt ID'));
          taxPayerId = data.invoiceInfo!
              .indexWhere((element) => element.label!.contains('Tax Payer ID'));
          custNumber = data.invoiceInfo!.indexWhere(
              (element) => element.label!.contains('Customer Number'));
          accountNumber = data.invoiceInfo!.indexWhere(
              (element) => element.label!.contains('Account Number'));
          poNumber = data.invoiceInfo!
              .indexWhere((element) => element.label!.contains('Po Number'));
          paymentTerms = data.invoiceInfo!.indexWhere(
              (element) => element.label!.contains('Payment Terms'));
          invoiceReceiptDate = data.invoiceInfo!.indexWhere(
              (element) => element.label!.contains('Invoice Receipt Date'));
          orderDate = data.invoiceInfo!
              .indexWhere((element) => element.label!.contains('Order Date'));
          dueDate = data.invoiceInfo!
              .indexWhere((element) => element.label!.contains('Due Date'));
          deliveryDate = data.invoiceInfo!.indexWhere(
              (element) => element.label!.contains('Delivery Date'));

          receiverName = data.receiver!.indexWhere(
              (element) => element.label!.contains('Receiver Name'));
          receiverAddress = data.receiver!.indexWhere(
              (element) => element.label!.contains('Receiver Address'));
          receiverPhone = data.receiver!.indexWhere(
              (element) => element.label!.contains('Receiver Phone'));
          receiverUrl = data.receiver!
              .indexWhere((element) => element.label!.contains('Receiver URL'));

          vendorName = data.vendor!
              .indexWhere((element) => element.label!.contains('Vendor Name'));
          vendorUrl = data.vendor!
              .indexWhere((element) => element.label!.contains('Vendor URL'));
          vendorAddress = data.vendor!.indexWhere(
              (element) => element.label!.contains('Vendor Address'));
          vendorPhone = data.vendor!
              .indexWhere((element) => element.label!.contains('Vendor Phone'));
          _fileName = 'No file chosen';
          iomData = data;
        });

        // var invoiceInfo = responses['Invoice Info'];
        // var vendor = responses['Vendor'];
        // var receiver = responses['Receiver'];
        // var table = responses['Table'];
        // var payment = responses['Payment'];
        // var other = responses['Other'];
        // data.invoiceInfo = invoiceInfo;
        // data.vendor = vendor;
        // data.receiver = receiver;
        // data.table = table;
        // data.payment = payment;
        // data.other = other;
        // if (status == 'FAILED') {
        //   setState(() {
        //     isLoading = false;
        //   });
        //   print('failed');
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(message)),
        //   );
        // } else if (status == 'SUCCESS') {
        //   Map<String, dynamic> read = responses['read'];
        //   Read reads = Read.fromJson(read);

        //   data.add(InvoiceOcrModel(
        //       invoiceInfo: date, message: message, read: reads, status: status));
        // }
      } else {
        setState(() {
          isLoading = false;
          _fileName = 'No file chosen';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request Failed')),
        );
      }
    } catch (e) {
      print('aaaa ${e}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${e}')),
      );
      setState(() {
        isLoading = false;
        _fileName = 'No file chosen';
      });
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("Assets/img/background-eendigo_(1).png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('OCR Invoice'),
          ),
          body: (isLoading == false)
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GradientText("OCR Invoice",
                              style: (TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold)),
                              colors: [
                                Color.fromARGB(255, 37, 162, 220),
                                Color.fromARGB(255, 28, 115, 185),
                                Color.fromARGB(255, 59, 67, 127),
                              ])),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 70, 10),
                          child: GradientText("Input",
                              style: (TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                              colors: [
                                Color.fromARGB(255, 37, 162, 220),
                                Color.fromARGB(255, 28, 115, 185),
                                Color.fromARGB(255, 59, 67, 127),
                              ])),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 70, 10),
                          child: ElevatedButton(
                            onPressed: () => _openFilePicker(context),
                            child: Text('Choose File'),
                          )
                          //Center(child: ImageCatcher(context)),
                          ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 70, 10),
                        child: Text('Selected File: $_fileName'),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(70, 0, 70, 10),
                          child: ElevatedButton(
                            child: Text('Submit'),
                            onPressed: _fileName == 'No file chosen'
                                ? null
                                : () async {
                                    try {
                                      if (invoiceFile != null) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        InvoiceOCRAPI(invoiceFile!)
                                            .then((rslt) {
                                          if (rslt.toString().isNotEmpty) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        });
                                      }
                                    } catch (e) {
                                      setState(() {
                                        isLoading = false;
                                        // errMsg = e.toString();
                                      });
                                    }
                                  },
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 70, 10),
                          child: GradientText("Output",
                              style: (TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                              colors: [
                                Color.fromARGB(255, 37, 162, 220),
                                Color.fromARGB(255, 28, 115, 185),
                                Color.fromARGB(255, 59, 67, 127),
                              ])),
                      SubSectionTitle("Invoice Info"),
                      InvoiceInfo(context),
                      SubSectionTitle("Receiver"),
                      Receiver(),
                      SubSectionTitle("Vendor"),
                      Vendor(),
                      SubSectionTitle("Payment"),
                      iomData == null ? Container() : Payment(),
                      SubSectionTitle("Table"),
                      iomData == null ? Container() : Tables(),
                      SubSectionTitle("Other"),
                      iomData == null ? Container() : Other()
                    ],
                  ),
                )
              : Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(child: CircularProgressIndicator())),
                )),
    );
  }

  Widget Tables() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: iomData == null ? 0 : iomData!.table!.length, // Number of rows
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 8, 0, 8),
              child: Text(
                'Page : ' + iomData!.table![index].page.toString(),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 8, 30, 8),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: List.generate(
                  iomData!.table![index].info!.length + 1,
                  (rowIndex) {
                    
                    return TableRow(
                      children: rowIndex == 0 ? 
                          List.generate(
                        iomData!.table![index].info![rowIndex].row!.length,
                        (colIndex) {
                          return TableCell(
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(iomData!.table![index].info![rowIndex]
                                    .row![colIndex].label
                                    .toString() + ' (' + iomData!.table![index].info![rowIndex]
                                    .row![colIndex].type
                                    .toString() + ')',style: TextStyle(fontWeight: FontWeight.bold)), ),
                          );
                        },
                      )
                       : List.generate(
                        iomData!.table![index].info![rowIndex - 1].row!.length,
                        (colIndex) {
                          return TableCell(
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(iomData!.table![index].info![rowIndex - 1]
                                    .row![colIndex].value
                                    .toString())),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget Tables() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: iomData == null ? 0 : iomData!.table!.length, // Number of rows
  //     itemBuilder: (context, index) {
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.fromLTRB(50, 8, 0, 8),
  //             child: Text(
  //               'Page : ' + iomData!.table![index].page.toString(),
  //               textAlign: TextAlign.left,
  //             ),
  //           ),
  //           ListView.builder(
  //               shrinkWrap: true,
  //               itemCount:
  //                   iomData == null ? 0 : iomData!.table![index].info!.length,
  //               itemBuilder: (context, indexRow) {
  //                 return Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.fromLTRB(70, 8, 0, 8),
  //                       child: Text(
  //                         'Row : ' + (indexRow + 1).toString(),
  //                         textAlign: TextAlign.left,
  //                       ),
  //                     ),
  //                     ListView.builder(
  //                       shrinkWrap: true,
  //                       itemCount: iomData == null
  //                           ? 0
  //                           : iomData!.table![index].info![indexRow].row!.length,
  //                       itemBuilder: (context, indexRowItem) {
  //                         return Card(
  //                           elevation: 0,
  //                           color: Colors.transparent,
  //                           child: Padding(
  //                             padding: const EdgeInsets.fromLTRB(80, 8, 0, 8),
  //                             child: ListTile(
  //                                 title: Text(iomData!.table![index].info![indexRow]
  //                                         .row![indexRowItem].label
  //                                         .toString() +
  //                                     ' (' +
  //                                     iomData!.table![index].info![indexRow].row![indexRowItem]
  //                                         .type
  //                                         .toString() +
  //                                     ')'), // Display Name
  //                                 subtitle: Text(iomData!.table![index].info![indexRow]
  //                                     .row![indexRowItem].value
  //                                     .toString())),
  //                           ), // Display Age and Occupation
  //                         );
  //                       },
  //                     ),
  //                   ],
  //                 );
  //               }),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget Payment() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          iomData == null ? 0 : iomData!.payment!.length, // Number of rows
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 8, 0, 8),
              child: Text(
                'Page : ' + iomData!.payment![index].page.toString(),
                textAlign: TextAlign.left,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  iomData == null ? 0 : iomData!.payment![index].info!.length,
              itemBuilder: (context, indexRow) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(80, 8, 0, 8),
                      child: ListTile(
                          title: Text(iomData!
                                  .payment![index].info![indexRow].label
                                  .toString() +
                              ' (' +
                              iomData!.payment![index].info![indexRow].type
                                  .toString() +
                              ')'), // Display Name
                          subtitle: Text(iomData!
                              .payment![index].info![indexRow].value
                              .toString())),
                    ), // Display Age and Occupation
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }

  Widget Other() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: iomData == null ? 0 : iomData!.other!.length, // Number of rows
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 8, 0, 8),
            child: ListTile(
                title: Text(
                    iomData!.other![index].label.toString()), // Display Name
                subtitle: Text(iomData!.other![index].value.toString())),
          ), // Display Age and Occupation
        );
      },
    );
  }

  Padding SubSectionTitle(String title) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 70, 10),
        child: GradientText(title,
            style: (TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            colors: [
              Color.fromARGB(255, 37, 162, 220),
              Color.fromARGB(255, 28, 115, 185),
              Color.fromARGB(255, 59, 67, 127),
            ]));
  }

  Visibility Vendor() {
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.vendor![vendorName].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.vendor![vendorAddress].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.vendor![vendorPhone].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.vendor![vendorUrl].value.toString(),
                    textAlign: TextAlign.left),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Visibility Receiver() {
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.receiver![receiverName].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.receiver![receiverAddress].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.receiver![receiverPhone].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.receiver![receiverUrl].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(iomData == null
                    ? ''
                    : iomData!.invoiceInfo![invoiceReceiptId].value.toString()),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![taxPayerId].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![custNumber].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![accountNumber].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![poNumber].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![paymentTerms].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![invoiceReceiptDate].value
                            .toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![orderDate].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![dueDate].value.toString(),
                    textAlign: TextAlign.left),
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
                child: Text(
                    iomData == null
                        ? ''
                        : iomData!.invoiceInfo![deliveryDate].value.toString(),
                    textAlign: TextAlign.left),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void _openFilePicker(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        fileBytes = result.files.first.bytes!;
        final fileName = result.files.single.name; // Original file name
        final file = File(fileName);
        invoiceFile = file;
        setState(() {
          _fileName = result.files.single.name;
        });
      } else {
        // User canceled the file picking.
      }
    } catch (e) {
      print("Error while picking the file: $e");
    }
  }
}
