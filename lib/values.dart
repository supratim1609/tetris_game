//Grid dimensions for the table
import 'dart:ui';

import 'package:flutter/material.dart';

int rowLength= 10;
int colLength= 15;

enum Direction{
  left,
  right,
  down,
}

enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetromino,Color> tetrominoColors={
  Tetromino.S:Colors.lightBlue,
  Tetromino.I:Colors.red,
  Tetromino.J:Colors.deepPurple,
  Tetromino.L:Colors.yellow,
  Tetromino.O:Colors.brown,
  Tetromino.T:Colors.orange,
  Tetromino.Z:Colors.green,
};