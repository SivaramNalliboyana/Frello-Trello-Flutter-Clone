import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:frello/core/error/exceptions.dart';
import 'package:frello/core/secrets/app_secrets.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class StripeRemoteDataSource {
  Future<Map<String, dynamic>> makePayment();
}

class StripeRemoteDataSourceImpl extends StripeRemoteDataSource {
  Future<String> createCustomer() async {
    String userEmail = Supabase.instance.client.auth.currentUser!.email!;
    Map<String, String> headers = {
      'Authorization': "Bearer ${StripeSecrets.SECRET_KEY}",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    // Search customer
    var response = await http.get(
      Uri.parse(
          "https://api.stripe.com/v1/customers/search?query=email:'$userEmail'"),
      headers: headers,
    );

    if (jsonDecode(response.body)["data"].isEmpty) {
      // Create customer if customer not registered
      var createCustomer = await http.post(
          Uri.parse("https://api.stripe.com/v1/customers"),
          headers: headers,
          body: {"email": userEmail});
      return jsonDecode(createCustomer.body)['id'];
    } else {
      return jsonDecode(response.body)["data"][0]["id"];
    }
  }

  createPaymentIntent(String amount, String currency, String customer) async {
    try {
      Map<String, dynamic> body = {
        "amount": (int.parse(amount) * 100).toString(),
        "currency": currency,
        "payment_method_types[]": "card",
        "customer": customer,
      };

      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          headers: {
            'Authorization': "Bearer ${StripeSecrets.SECRET_KEY}",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: body);

      // ignore: avoid_print
      print("Payment Intent Boy->>> ${response.body.toString()}");
      return jsonDecode(response.body);
    } catch (e) {
      // ignore: avoid_print
      print("Error charging the user: ${e.toString()}");
    }
  }

  @override
  Future<Map<String, dynamic>> makePayment() async {
    try {
      String customer = await createCustomer();
      Map<String, dynamic> paymentIntent =
          await createPaymentIntent("5", "USD", customer);

      return paymentIntent;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
