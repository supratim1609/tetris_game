import 'package:flutter/cupertino.dart';
import 'package:tetris_game/board.dart';
import 'package:tetris_game/values.dart';

class Piece{
  //types of tetris pieces
  Tetromino type;

  Piece({required this.type});

  //the pieces are just list of integers
  List<int> position = [];

  //colors of the pieces
  Color get color{
    return tetrominoColors[type]??
    const Color(0x0fffffff);
  }

  //generating the integers
  void initializePiece(){
    switch(type){
      case Tetromino.L:
        position=[
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position=[
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position=[
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position=[
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position=[
          -5,
          -6,
          -14,
          -15,
        ];
        break;
      case Tetromino.Z:
        position=[
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position=[
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  //move piece method
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

    //rotate piece
    int rotationState=1;
    void rotatePiece(){
      List<int> newPosition = [];

      //rotate piece according to the type
      switch (type) {
        case Tetromino.L:
          switch (rotationState) {
            case 0:
            //get the new position
              newPosition = [
                position[1] - rowLength,
                position[1],
                position[1] + rowLength,
                position[1] + rowLength + 1,
              ];
              //check if the move is valid
             if(piecePositionIsValid(newPosition)){
               //update position
               position = newPosition;
               //update rotation state
               rotationState = (rotationState + 1) % 4;
             }
              break;
            case 1:
            //get the new position
              newPosition = [
                position[1] - 1,
                position[1],
                position[1] + 1,
                position[1] + rowLength - 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 2:
            //get the new position
              newPosition = [
                position[1] + rowLength,
                position[1],
                position[1] - rowLength,
                position[1] - rowLength - 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 3:
            //get the new position
              newPosition = [
                position[1] - rowLength + 1,
                position[1],
                position[1] + 1,
                position[1] - 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
          }
        case Tetromino.J:
          switch (rotationState) {
            case 0:
            //get the new position
              newPosition = [
                position[1] - rowLength,
                position[1],
                position[1] + rowLength,
                position[1] + rowLength - 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 1:
            //get the new position
              newPosition = [
                position[1] - rowLength- 1,
                position[1],
                position[1] - 1,
                position[1] + 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 2:
            //get the new position
              newPosition = [
                position[1] + rowLength,
                position[1],
                position[1] - rowLength,
                position[1] - rowLength + 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 3:
            //get the new position
              newPosition = [
                position[1] + 1,
                position[1],
                position[1] - 1,
                position[1] + rowLength + 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
          }
        case Tetromino.I:
          switch (rotationState) {
            case 0:
            //get the new position
              newPosition = [
                position[1] - 1,
                position[1],
                position[1] + 1,
                position[1] + 2,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 1:
            //get the new position
              newPosition = [
                position[1] - rowLength,
                position[1],
                position[1] + rowLength,
                position[1] + 2 * rowLength ,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 2:
            //get the new position
              newPosition = [
                position[1] + 1,
                position[1],
                position[1] - 1,
                position[1] - 2,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 3:
            //get the new position
              newPosition = [
                position[1] + rowLength,
                position[1],
                position[1] - rowLength,
                position[1] - 2 * rowLength,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
          }

          //ommiting O because it has no rotation

        case Tetromino.S:
          switch (rotationState) {
            case 0:
            //get the new position
              newPosition = [
                position[1],
                position[1] + 1,
                position[1] + rowLength - 1,
                position[1] + rowLength,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 1:
            //get the new position
              newPosition = [
                position[0] - rowLength,
                position[0],
                position[0] + 1,
                position[0] + rowLength + 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 2:
            //get the new position
              newPosition = [
                position[1],
                position[1] + 1,
                position[1] + rowLength - 1,
                position[1] + rowLength,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 3:
            //get the new position
              newPosition = [
                position[0] - rowLength,
                position[0],
                position[0] + 1,
                position[0] + rowLength + 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
          }
        case Tetromino.Z:
          switch (rotationState) {
            case 0:
            //get the new position
              newPosition = [
                position[0] + rowLength - 2,
                position[1] ,
                position[2] + rowLength - 1,
                position[3] + 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 1:
            //get the new position
              newPosition = [
                position[0] - rowLength + 2,
                position[1],
                position[2] - rowLength + 1,
                position[3] - 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 2:
            //get the new position
              newPosition = [
                position[0] + rowLength - 2,
                position[1] ,
                position[2] + rowLength - 1,
                position[3] + 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 3:
            //get the new position
              newPosition = [
                position[0] - rowLength + 2,
                position[1],
                position[2] - rowLength + 1,
                position[3] - 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
          }
        case Tetromino.T:
          switch (rotationState) {
            case 0:
            //get the new position
              newPosition = [
                position[2] - rowLength,
                position[2],
                position[2] + 1,
                position[2] + rowLength,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 1:
            //get the new position
              newPosition = [
                position[1] - 1,
                position[1],
                position[1] + 1,
                position[1] + rowLength,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 2:
            //get the new position
              newPosition = [
                position[1] - rowLength,
                position[1] - 1,
                position[1],
                position[1] + rowLength,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
            case 3:
            //get the new position
              newPosition = [
                position[2] - rowLength,
                position[2] - 1,
                position[2] ,
                position[2] + 1,
              ];
              //check if the move is valid
              if(piecePositionIsValid(newPosition)){
                //update position
                position = newPosition;
                //update rotation state
                rotationState = (rotationState + 1) % 4;
              }
              break;
          }

          break;
        default:
      }
    }
    //check if the position is valid
    bool positionIsValid(int position){
      int row=(position / rowLength).floor();
      int col=position % rowLength;

      //if taken then return flase
      if(row < 0||col < 0||gameBoard[row][col]!=null){
        return false;
      }
      else{
        return true;
      }
    }

    //check peice position
    bool piecePositionIsValid(List<int> piecePosition){
      bool firstColOccupied=false;
      bool lastColOccupied=false;

      for (int pos in piecePosition){
        //return flase if any position is taken
        if(!positionIsValid(pos))
          return false;

        //get the coloumn of the position
        int col = pos % rowLength;

        if(col == 0){
          firstColOccupied=true;
        }
        if(col == rowLength-1){
          lastColOccupied=true;
        }
      }

      //if there is a peice in the first and the last col then the piece is out of bounds
      return !(firstColOccupied && lastColOccupied);
    }
 }


