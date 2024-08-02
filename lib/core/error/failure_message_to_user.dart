import 'package:flutter/material.dart';

Map<String, String> failureMessagesToUser(BuildContext context, String message) {
  String prefix = message.substring(0, message.indexOf(':'));
  switch (prefix) {
    case 'Connection Error' || 'Connection Time Out':
      return {
        'content': 'Network Error',
      };

    case 'Fetch Data Failure' ||
          'Send Time Out' ||
          'Receive Time Out' ||
          'Bad Certificate' ||
          'Cancel Failure' ||
          'Method Not Allowed' ||
          'Unprocessable Content' ||
          'Internal Server Failure' ||
          'Bad Request' ||
          'Not Found Resources' ||
          'Cache Failure':
      return {
        'content': 'App Server Error',
      };

    case 'Unauthorized' || 'Forbidden':
      return {
        'content': 'You are not allowed to access this',
      };

    case 'Duplicated Data':
      return {
        'content': 'Invalid Input',
      };
    case 'Missing Params Failure':
      return {
        'content': 'Make sure the required fields are filled',
      };
    default:
      return {
        'content': 'Unexpected Error',
      };
  }
}
