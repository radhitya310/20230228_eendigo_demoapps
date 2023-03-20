import 'package:eendigodemo/model/REKBCAModel.dart';
import 'package:flutter/material.dart';

class OCRBCAResults extends StatelessWidget {
  final List<Rekbcaocr> data;
  const OCRBCAResults({required this.data});

  // final List<Widget> data1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: const [
                            Icon(Icons.search),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Find services, food, or place',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Text('AccountNumber : ' + data[0].read.identity.accountNumber),
            Text('AlternateIncome1 : ' +
                data[0].read.identity.alternateIncome1.toString()),
            Text('AlternateIncome2 : ' +
                data[0].read.identity.alternateIncome2.toString()),
            Text('AlternateIncome3 : ' +
                data[0].read.identity.alternateIncome3.toString()),
            Text('AlternateIncome4 : ' +
                data[0].read.identity.alternateIncome4.toString()),
            Text('AlternateIncomeFinal : ' +
                data[0].read.identity.alternateIncomeFinal.toString()),
            Text('CreditTransactionsLast3Months : ' +
                data[0].read.identity.creditTransactionsLast3Months.toString()),
            Text('DebitTransactionsLast3Months : ' +
                data[0].read.identity.debitTransactionsLast3Months.toString()),
            Text('EndingBalance : ' +
                data[0].read.identity.endingBalance.toString()),
            Text('Name : ' + data[0].read.identity.name),
            Text('TotalTransactionsCreditLast3Months : ' +
                data[0]
                    .read
                    .identity
                    .totalTransactionsCreditLast3Months
                    .toString()),
            Text('TotalTransactionsDebitLast3Months : ' +
                data[0]
                    .read
                    .identity
                    .totalTransactionsDebitLast3Months
                    .toString()),
            Text('TotalTransactionsLast3Months : ' +
                data[0].read.identity.totalTransactionsLast3Months.toString()),
            Text('WarningMutasi1 : ' +
                data[0].read.identity.warningMutasi1.toString()),
            Text('WarningMutasi1Description : ' +
                data[0].read.identity.warningMutasi1Description),
            for (int i = 0;
                i < data[0].read.transactionHistory.length;
                i++) ...{
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('Data  ${i + 1}'),
                    Table(
                      border: TableBorder.all(width: 1.0, color: Colors.grey),
                      children: [
                        if (data[0].read.transactionHistory.isNotEmpty) ...{
                          TableRow(children: [
                            TableCell(child: Text('Amount')),
                            TableCell(
                                child: Text(data[0]
                                    .read
                                    .transactionHistory[i]
                                    .amount
                                    .toString())),
                          ]),
                          TableRow(children: [
                            TableCell(child: Text('Date')),
                            TableCell(
                                child: Text(
                                    data[0].read.transactionHistory[i].date)),
                          ]),
                          TableRow(children: [
                            TableCell(child: Text('Description')),
                            TableCell(
                                child: Text(data[0]
                                    .read
                                    .transactionHistory[i]
                                    .description)),
                          ]),
                          TableRow(children: [
                            TableCell(child: Text('Ending Balance')),
                            TableCell(
                                child: Text(data[0]
                                    .read
                                    .transactionHistory[i]
                                    .endingBalance
                                    .toString())),
                          ]),
                          TableRow(children: [
                            TableCell(child: Text('Type')),
                            TableCell(
                                child: Text(data[0]
                                    .read
                                    .transactionHistory[i]
                                    .type
                                    .toString())),
                          ]),
                        }
                      ],
                    ),
                  ],
                ),
              )
            },
            for (int i = 0;
                i < data[0].read.transactionHistory.length - 1;
                i++) ...{
              Text('Beggining Balance : ' +
                  data[0]
                      .read
                      .transactionSummary[i]
                      .beginningBalance
                      .toString()),
              Text('Credit : ' +
                  data[0].read.transactionSummary[i].credit.toString()),
              Text('Credit Freq : ' +
                  data[0].read.transactionSummary[i].creditFreq.toString()),
              Text('Debit : ' +
                  data[0].read.transactionSummary[i].debit.toString()),
              Text('Debit Freq: ' +
                  data[0].read.transactionSummary[i].debitFreq.toString()),
              Text('Ending Balance : ' +
                  data[0].read.transactionSummary[i].endingBalance.toString()),
              Text('Period : ' +
                  data[0].read.transactionSummary[i].period.toString()),
              Text('warning Mutasi 2 : ' +
                  data[0].read.transactionSummary[i].warningMutasi2.toString()),
              Text('Warning Mutasi 2 Description : ' +
                  data[0]
                      .read
                      .transactionSummary[i]
                      .warningMutasi2Description
                      .toString()),
            },
          ],
        )),
      ),
    );
  }
}
