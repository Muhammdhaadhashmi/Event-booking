import 'package:flutter/material.dart';
import 'package:merriage_management/Utils/spaces.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/text_view.dart';

class InvoiceService extends StatelessWidget {
  final bool isHeader;
  final String serial;
  final String service;
  final String quantity;
  final String price;
  final String unit;
  final String total;

  const InvoiceService({
    super.key,
    this.isHeader = false,
    required this.serial,
    required this.service,
    required this.quantity,
    required this.price,
    required this.unit,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TextView(
                text: serial,
                color: AppColors.black,
                fontSize: isHeader ? 16 : 14,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.w400,
              ),
              AddHorizontalSpace(5),
              TextView(
                text: service,
                color: AppColors.black,
                fontSize: isHeader ? 16 : 14,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.w400,
              ),
            ],
          ),
          Container(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  child: TextView(
                    text: quantity,
                    color: AppColors.black,
                    fontSize: isHeader ? 16 : 14,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.w400,
                  ),
                ),
                Container(
                  width: 50,
                  child: TextView(
                    text:price,
                    color: AppColors.black,
                    fontSize: isHeader ? 16 : 14,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.w400,
                  ),
                ),
                Container(
                  width: 50,
                  child: TextView(
                    text: unit,
                    color: AppColors.black,
                    fontSize: isHeader ? 16 : 14,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.w400,
                  ),
                ),
                Container(
                  width: 50,
                  child: TextView(
                    text: total,
                    color: AppColors.black,
                    fontSize: isHeader ? 16 : 14,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
