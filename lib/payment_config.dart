//
// void onGooglePayButtonTap() {
//   var googlePayButton = GooglePayButton(
//     paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
//     paymentItems: const [
//       PaymentItem(
//         label: 'Total',
//         amount: '1',
//         status: PaymentItemStatus.final_price,
//       )
//     ],
//     type: GooglePayButtonType.pay,
//     margin: const EdgeInsets.only(top: 15.0),
//     onPaymentResult: (result) => debugPrint('Payment Result $result'),
//     loadingIndicator: const Center(
//       child: CircularProgressIndicator(),
//     ),
//   );
//
//   // You can add the Google Pay button to your widget tree or perform any other actions.
//   // For example, you can show a dialog with the Google Pay button.
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text('Payment'),
//       content: googlePayButton,
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context); // Close the dialog
//           },
//           child: Text('Close'),
//         ),
//       ],
//     ),
//   );
// }
// /// Sample configuration for Google Pay. Contains the same content as the file
// /// under `assets/default_payment_profile_google_pay.json`.
// const String defaultGooglePay = '''{
//   "provider": "google_pay",
//   "data": {
//     "environment": "TEST",
//     "apiVersion": 2,
//     "apiVersionMinor": 0,
//     "allowedPaymentMethods": [
//       {
//         "type": "CARD",
//         "tokenizationSpecification": {
//           "type": "PAYMENT_GATEWAY",
//           "parameters": {
//             "gateway": "example",
//             "gatewayMerchantId": " BCR2DN4TY24JRECJ"
//           }
//         },
//         "parameters": {
//           "allowedCardNetworks": ["VISA", "MASTERCARD"],
//           "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
//           "billingAddressRequired": true,
//           "billingAddressParameters": {
//             "format": "FULL",
//             "phoneNumberRequired": true
//           }
//         }
//       }
//     ],
//     "merchantInfo": {
//       "merchantId": " BCR2DN4TY24JRECJ",
//       "merchantName": "Example Merchant Name"
//     },
//     "transactionInfo": {
//       "countryCode": "IN",
//       "currencyCode": "INR"
//     }
//   }
// }''';
//
// const String basicGooglePayIsReadyToPay = '''{
//   "apiVersion": 2,
//   "apiVersionMinor": 0,
//   "allowedPaymentMethods": [
//     {
//       "type": "CARD",
//       "parameters": {
//         "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
//         "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
//       }
//     }
//   ]
// }''';
//
// const String basicGooglePayLoadPaymentData = '''{
//   "apiVersion": 2,
//   "apiVersionMinor": 0,
//   "merchantInfo": {
//     "merchantName": "Example Merchant"
//   },
//   "allowedPaymentMethods": [
//     {
//       "type": "CARD",
//       "parameters": {
//         "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
//         "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
//       },
//       "tokenizationSpecification": {
//         "type": "PAYMENT_GATEWAY",
//         "parameters": {
//           "gateway": "example",
//           "gatewayMerchantId": " BCR2DN4TY24JRECJ"
//         }
//       }
//     }
//   ],
//   "transactionInfo": {
//     "totalPriceStatus": "FINAL",
//     "totalPrice": "12.34",
//     "currencyCode": "USD"
//   }
// }''';
//
// const String invalidGooglePayIsReadyToPay = '''{
//   "apiVersion": 2,
//   "apiVersionMinor": 0,
//   "allowedPaymentMethods": [
//     {
//       "type": "CARD",
//       "parameters": {}
//     }
//   ]
// }''';
//
// const String invalidGooglePayLoadPaymentData = '''{
//   "apiVersion": 2,
//   "apiVersionMinor": 0,
//   "merchantInfo": {
//     "merchantName": "Anoop"
//   },
//   "allowedPaymentMethods": [
//     {
//       "type": "CARD",
//       "parameters": {
//         "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
//         "allowedCardNetworks": ["AMEX", "DISCOVER", "INTERAC", "JCB", "MASTERCARD", "VISA"]
//       },
//       "tokenizationSpecification": {
//         "type": "PAYMENT_GATEWAY",
//         "parameters": {
//           "gateway": "example",
//           "gatewayMerchantId": " BCR2DN4TY24JRECJ"
//         }
//       }
//     }
//   ],
//   "transactionInfo": {
//     "totalPriceStatus": "FINAL",
//     "totalPrice": "12.34",
//     "currencyCode": "USD"
//   }
// }''';