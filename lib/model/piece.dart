import 'package:flutter/material.dart';
import 'package:tetris_game/constants/directions.dart';
import 'package:tetris_game/model/game_board.dart';
import 'package:tetris_game/constants/tetrominoes.dart';

class Piece {
  // Shape of the piece
  Tetrominoes type;
  Piece({required this.type});

  // Each piece is a list of positions
  List<int> position = [];

  // Color of the piece
  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  // Generate integers
  void initPiece() {
    switch (type) {
      case Tetrominoes.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetrominoes.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetrominoes.I:
        position = [-35, -25, -15, -5];
        break;
      case Tetrominoes.O:
        position = [-16, -15, -6, -5];
        break;
      case Tetrominoes.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetrominoes.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetrominoes.T:
        position = [-26, -16, -15, -6];
        break;
    }
  }

  // Move a piece by one pixel
  void movePiece(Directions direction) {
    switch (direction) {
      case Directions.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Directions.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      case Directions.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rows;
        }
        break;
    }
  }

  // Rotate piece
  int rotationState = 0;

  bool isValidPosition(int pos) {
    int row = (pos / rows).floor();
    int col = pos % rows;
    // Check if the position is already taken
    if (row < 0 || col < 0 || row >= columns || col >= rows || gameBoard[row][col] != null) {
      return false;
    }
    return true;
  }

  bool isValidPiecePosition(List<int> piecePos) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in piecePos) {
      // Check if the position is already taken
      if (!isValidPosition(pos)) {
        return false;
      }
      int col = pos % rows;
      // Check if it is contained in the first or last column
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rows - 1) {
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }

  void rotatePiece() {
    List<int> newPosition = [];
    switch (type) {
      case Tetrominoes.L:
        switch (rotationState) {
          case 0:
            /*
                #
                #
                # #
            */
            newPosition = [
              position[1] - rows,
              position[1],
              position[1] + rows,
              position[1] + rows + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
                # # #
                #
            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rows - 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
                # #
                  #
                  #
            */
            newPosition = [
              position[1] + rows,
              position[1],
              position[1] - rows,
              position[1] - rows - 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                    #
                # # #
            */
            newPosition = [
              position[1] - rows + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetrominoes.J:
        switch (rotationState) {
          case 0:
            /*
                  #
                  #
                # # 
            */
            newPosition = [
              position[1] - rows,
              position[1],
              position[1] + rows,
              position[1] + rows - 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
                #
                # # #
            */
            newPosition = [
              position[1] - rows - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
                # #
                #
                #
            */
            newPosition = [
              position[1] + rows,
              position[1],
              position[1] - rows,
              position[1] - rows + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                # # #
                    #
            */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rows + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetrominoes.I:
        switch (rotationState) {
          case 0:
            /*
                #
                #
                #
                # 
            */
            newPosition = [
              position[1] - rows,
              position[1],
              position[1] + rows,
              position[1] + 2*rows,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
                # # # #
            */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
                #
                #
                #
                # 
            */
            newPosition = [
              position[1] + rows,
              position[1],
              position[1] - rows,
              position[1] - 2*rows,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                # # # #
            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetrominoes.O:
        /*
          The O tetromino doesn't need to be rotated
            # #
            # #
        */
        break;

      case Tetrominoes.S:
        switch (rotationState) {
          case 0:
            /*
                  # #
                # # 
            */
            newPosition = [
              position[0] - rows,
              position[0],
              position[0] + 1,
              position[0] + rows + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
                #
                # # 
                  #
            */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rows - 1,
              position[1] + rows,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
                # #
              # #
            */
            newPosition = [
              position[0] - rows,
              position[0],
              position[0] + 1,
              position[0] + rows + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                #
                # # 
                  #
            */
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rows - 1,
              position[1] + rows,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetrominoes.Z:
        switch (rotationState) {
          case 0:
            /*
                # #
                  # # 
            */
            newPosition = [
              position[0] - rows + 2,
              position[1],
              position[2] - rows + 1,
              position[3] - 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
                  #
                # # 
                #
            */
            newPosition = [
              position[0] + rows - 2,
              position[1],
              position[2] + rows - 1,
              position[3] + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
                # #
                  # #
            */
            newPosition = [
              position[0] - rows + 2,
              position[1],
              position[2] - rows + 1,
              position[3] - 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                  #
                # # 
                # 
            */
            newPosition = [
              position[0] + rows - 2,
              position[1],
              position[2] + rows - 1,
              position[3] + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetrominoes.T:
        switch (rotationState) {
          case 0:
            /*
                +
                + +
                + 
            */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rows,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
                + + +
                  +
            */
            newPosition = [
              position[1] - rows,
              position[1] - 1,
              position[1],
              position[1] + rows,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
                  +
                + +
                  +
            */
            newPosition = [
              position[2] - rows,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                  +
                + + +
            */
            newPosition = [
              position[2] - rows,
              position[2],
              position[2] + 1,
              position[2] + rows,
            ];
            if (isValidPiecePosition(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
    }
  }
}