import 'package:flutter/material.dart';

import 'header.dart';
import 'request_item.dart';
import 'request_item_widget.dart';
import 'transaction_item.dart';
import 'transaction_item_widget.dart';

class ListBudgetScreen extends StatelessWidget {
  const ListBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Trip Budget',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: const Color(0xFF15161E),
            fontSize: 32,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        16,
                        12,
                        16,
                        12,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Header(
                                text: 'Available Balance',
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  4,
                                  0,
                                  0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  12,
                                  0,
                                  0,
                                ),
                                child: Text(
                                  '\$200.50',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall?.copyWith(
                                    color: const Color(0xFF15161E),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FilledButton(
                            onPressed: () async {},
                            child: const Text('Request'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Header(
                    text: 'Recent Requests',
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var requestItem in requestItemList) ...[
                          RequestItemWidget(requestItem: requestItem),
                          const SizedBox(width: 12),
                        ],
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Header(
                    text: 'Transactions',
                    padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 44),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      for (var transactionItem in transactionItemList)
                        TransactionItemWidget(transactionItem: transactionItem),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
