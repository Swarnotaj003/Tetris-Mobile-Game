import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris_game/constants/directions.dart';
import 'package:tetris_game/model/piece.dart';
import 'package:tetris_game/util/game_over_dialog.dart';
import 'package:tetris_game/util/pixel.dart';
import 'package:tetris_game/constants/tetrominoes.dart';

// Board dimensions
final int rows = 10;
final int columns = 15;

/*
  GAME BOARD

  This is a matrix with null representing empty state and
  We will store the tetrominoe type to present the correct color of landed pieces
*/

List<List<Tetrominoes?>> gameBoard = List.generate(
  columns,
  (i) => List.generate(rows, (j) => null),
);

// Frame refresh rate
final Duration frameRate = const Duration(milliseconds: 400);


class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // STATE MEMBERS
  // Current tetris piece
  Piece currentPiece = Piece(type: Tetrominoes.L);

  // Current score
  int currentScore = 0;

  // Game status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    // Start the game as soon as the app starts
    startGame();
  }

  // GAME CONTROL FLOW
  // 1) Start
  void startGame() {
    currentPiece.initPiece();
    gameLoop(frameRate);
  }

  // 2) Loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // Clear filled rows if any
        clearLines();

        // Check for landing
        checkLanding();
        
        // Check if the game is over
        if (gameOver) {
          timer.cancel();
          // GAME OVER MESSAGE
          showDialog(
            context: context,
            builder:
                (context) => GameOverDialog(
                  score: currentScore.toString(),
                  restart: resetGame,
                ),
          );
        }

        // Move piece down
        currentPiece.movePiece(Directions.down);
      });
    });
  }

  // 3) Reset
  void resetGame() {
    // Clear the board
    gameBoard = List.generate(columns, (i) => List.generate(rows, (j) => null));
    
    // Reset all the state members
    gameOver = false;
    currentScore = 0;
    createNewPiece();

    // Start the game
    startGame();
  }


  // UTILITY METHODS
  // 1) Check for collision with walls or other pieces
  bool checkCollision(Directions direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rows).floor();
      int col = currentPiece.position[i] % rows;
      switch (direction) {
        case Directions.left:
          col -= 1;
          break;
        case Directions.right:
          col += 1;
          break;
        case Directions.down:
          row += 1;
          break;
      }
      // Check if it goes through the walls or bottom
      if (row >= columns || col < 0 || col >= rows) {
        return true;
      }
      // Check if it lands on other landed pieces
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  // 2) Check if the current piece landed to the bottom
  void checkLanding() {
    if (checkCollision(Directions.down)) {
      // Mark the positions as occupied
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rows).floor();
        int col = currentPiece.position[i] % rows;
        if (row >= 0 && col >= 0 && row < columns && col < rows) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      // Once landed, create a new piece
      createNewPiece();
    }
  }

  // 3) Initialize a new piece
  void createNewPiece() {
    Random rand = Random();
    Tetrominoes randType = Tetrominoes.values[rand.nextInt(Tetrominoes.values.length)];
    currentPiece = Piece(type: randType);
    currentPiece.initPiece();
    if (isGameOver()) {
      gameOver = true;
    }
  }


  // GAME CONTROLS
  // 1) Shift left
  void moveLeft() {
    if (!checkCollision(Directions.left)) {
      setState(() {
        currentPiece.movePiece(Directions.left);
      });
    }
  }

  // 2) Shift right
  void moveRight() {
    if (!checkCollision(Directions.right)) {
      setState(() {
        currentPiece.movePiece(Directions.right);
      });
    }
  }

  // 3) Rotate right
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }


  // GAME RULE DRIVERS
  // 1) Clear filled rows & update score
  void clearLines() {
    for (int row = columns-1; row >= 0; row--) {
      // Check if the row is full
      bool rowIsFull = true;
      for (int col = 0; col < rows; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      // If the row is full, clear the row & shift the above rows down
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = gameBoard[r-1];
        }
        gameBoard[0] = List.generate(rows, (i) => null);
        currentScore += rows;
      }
    }
  }

  // 2) Check for game over
  bool isGameOver() {
    // Check if any column of top row is filled
    for (int col = 0; col < rows; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('T E T R I S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // GAME GRID
          Expanded(
            child: GridView.builder(
              itemCount: rows * columns,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rows,
              ),
              itemBuilder: (context, index) {
                int row = (index / rows).floor();
                int col = index % rows;

                // Current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(color: currentPiece.color);
                }
                // Landed pieces
                if (gameBoard[row][col] != null) {
                  return Pixel(color: tetrominoColors[gameBoard[row][col]]);
                }
                // Blank pixel
                return Pixel(color: Colors.grey[900]);
              },
            ),
          ),

          // SCORE
          Text(
            'S C O R E : $currentScore',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
             
            ),
          ),

          // GAME CONTROLS
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: moveLeft,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: 32,
                  ),
                ),
                IconButton(
                  onPressed: rotatePiece,
                  icon: Icon(Icons.rotate_right, color: Colors.grey, size: 32),
                ),
                IconButton(
                  onPressed: moveRight,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
