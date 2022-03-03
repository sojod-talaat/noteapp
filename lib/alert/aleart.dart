import 'package:flutter/material.dart';

show(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center( 
          child: Container(
            height: 200,
            child: AlertDialog(
              title: Text('PLASE WAIT'),
              content: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        );
      });
}
