import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
showMsg (BuildContext context ,String msg)=>
    ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(content:Text(msg)));