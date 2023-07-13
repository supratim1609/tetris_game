import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/piece.dart';
import 'package:tetris_game/pixels.dart';
import 'package:tetris_game/values.dart';

//make the gamebord
List<List<Tetromino?>> gameBoard = List.generate(
    colLength,
        (i) => List.generate(
          rowLength,
            (j) => null,
        ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  //current score
  int currentScore=0;

  //game over status
  bool gameOver=false;

  //current tetris piece
  Piece currentPiece= Piece(type: Tetromino.L);

  @override
  void initState() {
    super.initState();
    //start the game when the app starts
    startGame();
  }
  void startGame(){
    currentPiece.initializePiece();

    //frame refresh rate
    Duration frameRate= const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  //game loop
  void gameLoop(frameRate){
    Timer.periodic(
      frameRate,
        (timer){
        setState(() {
          //clear lines
          clearLine();

          //check for landing
          checkLanding();

          //check for game over
          if(gameOver==true){
            timer.cancel();
            showGameOverDialoge();
          }

          //move current piece down
          currentPiece.movePiece(Direction.down);
        });
        },
    );
  }

  void showGameOverDialoge(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text('Game Over!!'),
      content: Text('Your Score: $currentScore'),
      actions: [
        TextButton(onPressed: (){
          //reset game method
          resetGame();
          Navigator.pop(context);
        },
            child: Text('Play Again'))
      ],
    ));
  }

  //reset game
  void resetGame(){
    //clear the game board
    gameBoard= List.generate(
      colLength,
          (i) => List.generate(
        rowLength,
            (j) => null,
      ),
    );

    //new game starts
    gameOver=false;
    currentScore=0;

    //create new piece
    createNewPiece();

    //start new game
    startGame();
  }

  //collision check and also determine future position
  //return true if collision happens
  //return false if collision do not happen

  bool collisionCheck(Direction direction){
    //loop through all position of each piece
    for(int i=0 ; i < currentPiece.position.length ; i++){
      //get the current position of the piece
      int row=(currentPiece.position[i] / rowLength).floor();
      int col=currentPiece.position[i] % rowLength;

      //adjust the position according to the position
      if(direction == Direction.left){
        col -= 1;
      }else if(direction == Direction.right) {
        col += 1;
      }else if(direction == Direction.down){
        row += 1;
      }

      //check if the position is out of bounds
      if(row >= colLength||col<0||col>=rowLength) {
        return true;
      }
    }
    //if no collision is detected then return false
    return false;
  }

  // void checkLanding(){
  //   //if going down is true
  //   if(collisionCheck(Direction.down)){
  //     //mark the position as occupied
  //     for(int i=0; i < currentPiece.position.length ; i++){
  //       int row=(currentPiece.position[i] / rowLength).floor();
  //       int col=currentPiece.position[i] % rowLength;
  //       if(row>=0 && col>=0){
  //         gameBoard[row][col]=currentPiece.type;
  //       }
  //     }
  //     //when landed it creates a new piece
  //     createNewPiece();
  //   }
  // }
  void checkLanding() {
    // if going down is occupied or landed on other pieces
    if (collisionCheck(Direction.down) || checkLanded()) {
      // mark position as occupied on the game board
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once landed, create the next piece
      createNewPiece();
    }
  }

  bool checkLanded() {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // check if the cell below is already occupied
      if (row + 1 < colLength && row >= 0 && gameBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }
    }

    return false; // no collision with landed pieces
  }

  void createNewPiece(){
    //create random object for every time from the tetromino types
    Random rand = Random();

    //create a new piece with random type
    Tetromino randomType= Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece=Piece(type: randomType);
    currentPiece.initializePiece();

    //the check is here because we want a new piece on the top row but not in case of game over
    if(isGameOver()){
      gameOver=true;
    }
  }

  //moving left
  void moveLeft(){
    //make sure to check if the move is valid
    if(!collisionCheck(Direction.left)){
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  //rotate piece
  void rotatePiece(){
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  //clear lines method
  void clearLine(){
    //1=> loop through each row of game board
    for(int row = colLength-1;row >= 0; row--){
      //2=> initialize a variable to track the row is full
      bool rowIsFull = true;

      //3=> check if the row is full with pieces
      for(int col = 0; col < rowLength; col++){
        //if there is any coloumn empty then set rowIsFull to false
        if(gameBoard[row][col]==null){
          rowIsFull = false;
          break;
        }
      }
      //4=> if the row is full then clear the row and move it down
      if(rowIsFull){
        //5=> move all the rows down
        for(int r=row;r>0;r--){
          //6=> copy above row to current row
          gameBoard[r]=List.from(gameBoard[r-1]);
        }
        //6=>set the top row to empty
        gameBoard[0]=List.generate(row, (index) => null);

        //7=> increase the score
        currentScore++;
      }
    }
  }

  //game over method
  bool isGameOver(){
    //check if the coloumn in the top row is occupied
    for (int col = 0; col<rowLength; col++){
      if(gameBoard[0][col]!=null){
        return true;
      }
    }
    //if top row is empty
    return false;
  }

  //moving right
  void moveRight(){
    if(!collisionCheck(Direction.right)){
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0,40.0,0.0,0.0),
        child: Column(
          children: [
            //game grid
            Expanded(
              child: GridView.builder(
                itemCount: rowLength * colLength,
                   physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength),
                  itemBuilder: (context,index){

                  //get row and col of each index
                    int row=(index / rowLength).floor();
                    int col=index % rowLength;

                  if(currentPiece.position.contains(index)){
                    //current pixel
                    return Pixel(
                      color: currentPiece.color,
                    );
                  }
                  //landed piece
                  else if(gameBoard[row][col]!=null){
                    final Tetromino? tetrominoType=gameBoard[row][col];
                    return Pixel(color: tetrominoColors[tetrominoType]);
                  }
                  //blank pixel
                  else
                    return Pixel(
                      color: Colors.grey[900],
                    );
                }
              ),
            ),

            //display score
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,20.0),
              child: Text(
              "Score: " + currentScore.toString(),
              style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0)
              ),
            ),
            //game controls
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                //left
                IconButton(onPressed: moveLeft,color: Colors.white, icon:Icon(Icons.arrow_back)),

                //rotate
                IconButton(onPressed: rotatePiece,color: Colors.white, icon:Icon(Icons.rotate_right_outlined)),

                //right
                IconButton(onPressed: moveRight,color: Colors.white, icon:Icon(Icons.arrow_forward)),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
