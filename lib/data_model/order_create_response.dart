// To parse this JSON data, do
//
//     final orderCreateResponse = orderCreateResponseFromJson(jsonString);

import 'dart:convert';

OrderCreateResponse orderCreateResponseFromJson(String str) => OrderCreateResponse.fromJson(json.decode(str));

String orderCreateResponseToJson(OrderCreateResponse data) => json.encode(data.toJson());

class OrderCreateResponse {
  OrderCreateResponse({
    this.combined_order_id,
    this.result,
    this.message,
    this.payment_url,
  });

  String? payment_url;
  int? combined_order_id;
  bool? result;
  String? message;

  factory OrderCreateResponse.fromJson(Map<String, dynamic> json) => OrderCreateResponse(
    combined_order_id: json["combined_order_id"],
    result: json["result"],
    message: json["message"],
    payment_url: json["payment_url"],
  );

  Map<String, dynamic> toJson() => {
    "payment_url": payment_url,
    "combined_order_id": combined_order_id,
    "result": result,
    "message": message,
  };
}