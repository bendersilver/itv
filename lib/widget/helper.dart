import 'package:flutter/material.dart';

Text wsText(String v, [double fs]) {
  return Text(
    v,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(shadows: <Shadow>[
      Shadow(
        blurRadius: 3.0,
        color: Colors.black,
      ),
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 2.0,
        color: Colors.black,
      ),
    ], color: Colors.white, fontWeight: FontWeight.w600, fontSize: fs ?? 18),
  );
}
