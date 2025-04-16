import 'package:flutter/material.dart';

enum Tetrominoes {
  L,
  J,
  I, 
  O, 
  S, 
  Z,
  T, 

/*
  Shapes: 

  #
  #
  # #

    #
    #
  # # 

  #
  #
  # 
  #

  # #
  # #

    # #
  # #

  # #
    # #

  #
  # #
  # 

*/
}

const Map<Tetrominoes, Color> tetrominoColors = {
  Tetrominoes.L : Colors.orange,
  Tetrominoes.J : Colors.lightBlue,
  Tetrominoes.I : Colors.pinkAccent,
  Tetrominoes.O : Colors.yellow,
  Tetrominoes.S : Colors.green,
  Tetrominoes.Z : Colors.red,
  Tetrominoes.T : Colors.purple
};