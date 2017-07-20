//reference : marco's lectures and videos. reference of processing.com ,  picture : http://fredodiable.com/Mes%20sites/PHP/morpion/images/morpion_fdj.jpg //<>// //<>//

// this is a game TIC TAC TOE
// one player or 2 player
// one player : you play against the computer . you have to have 3 circle in a col, row or diagonal to win
// 2player : you play against an oter person


Cell[][] board;  // array for board
int cols = 3;  
int rows = 3;
int player = 0; //0 = player1
int win = 0;  // 1 = player1   2 = player2;
int game = 0;  // 1 = game started
int full = 9;  // 9 when the array is empty
PImage photo;
int scoreX=0;   // score of X
int scoreO=0;   // score of O
int nil=0;      // no one win
boolean stop=true;
int random=0;

void setup() {
  size(1000, 1000);
  smooth(); 
  photo = loadImage("morpion.jpg"); // load image
  board = new Cell[cols][rows];
  for (int i = 0; i< cols; i++) {  // initializes square to make a board
    for ( int j = 0; j < rows; j++) {
      board[i][j] = new Cell((800*i+200)/4, (800*j+200)/4, 800/4, 800/4);
    }
  }
}

void draw() {
  background(0);
  // intro, first page, picture, presentation
  if (game == 0) {
    image(photo, 0, 0, width, height); // draw the image on the background of the intro
    fill(40, 15, 249);
    textSize(40);
    text("Press ENTER to Start", width/5, height-10);
  }
  // menu : one player or 2player
  if (game==1) {
    background(100, 15, 249);
    fill(255);
    strokeWeight(5);
    rect(width/10-5, height/3+10, 480, -50);
    rect(width/10-5, height+10-height/3, 480, -50);
    fill(40, 15, 249);
    textSize(50);

    text("one player press X", width/10, height/3);
    text("two player press O", width/10, height-height/3);
  }

  //game one player (play against the computer)
  if (game == 2 ) {

    checkGame();  // check if  player win

    for (int i = 0; i<cols; i++) { // draw the board
      for (int j = 0; j<rows; j++) {
        board[i][j].display();//  draw circl or crosse you click or the computer play
      }
    }
    fill(255);
    textSize(30);

    text("press m to menu", 300, 920);
    fill(255, 0, 0);
    text("X =" +scoreX, 900, 200);
    fill(0, 0, 255);
    text("O =" +scoreO, 900, 300);
    fill(255);
    text("nil ="+nil, 900, 400);
    if (win==0) { // if no one win 
      if (random==0) { // if random = 0 the computer play  because of the algorithm I made down (move1,move2,move3)
        computer();// first move : computer. if the second move of the ^player is the middle, then
      }
      if (full==7 && board[1][1].checkState()==1) { // only chance for the player to win : if his first move is the center, then the computer use a random
        random=1;
      }


      if ( random==1) {
        move5(); // fonction random : the computer don't think .it use a random.
      }
    }
  }

  // game 2 player  
  if (game==3) {
    checkGame();
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        board[i][j].display();
      }
    }
    fill(255);
    textSize(30);
    text("press m to menu", 300, 920);
    fill(255, 0, 0);
    text("X ="+scoreX, 900, 200);
    fill(0, 0, 255);
    text("O ="+scoreO, 900, 300);
    fill(255);
    text("nil ="+nil, 900, 400);
  }
}

//mouse & key functions
void mousePressed() {
  if (game == 2 || game==3) {
    if (win == 0) {
      for (int i = 0; i<cols; i++) {
        for (int j = 0; j<rows; j++) {
          board[i][j].click(mouseX, mouseY);  // draw cross or circle when you click in a rectangle
        }
      }
    }
  }
}
// possibility when you play against the computer (there is more possibility but i didn't finish)
void computer() {

  if (full==9) {
    board[0][0].choice();
  }
  if (full==7) {
    move1();
  }
  if (full==5) {
    move2();
  }
  if (full==3) {
    move3();
  }
}


// move of the computer(second one) after the first move of the player

void move1() {
  // if the player plays 
  if (full==7 && (board[1][0].checkState()==1||board[2][0].checkState()==1||board[2][1].checkState()==1 || board[1][2].checkState()==1 || board[2][2].checkState()==1)) {
    board[0][2].choice();
  }
  if (full==7 && (board[0][2].checkState()==1||board[0][1].checkState()==1)) {
    board[2][0].choice();
  }
}


/* move of the computer(third one) after the second move of the player*/

void move2() {
  if (full==5 && board[0][2].checkState()==2 && board[0][1].checkState()==0) {
    board[0][1].choice();
  }
  if (full==5 && board[2][0].checkState()==2 && board[1][0].checkState()==0) {
    board[1][0].choice();
  }
  if (full==5 && board[2][1].checkState()==1 && board[0][1].checkState()==1 && board[1][1].checkState()==0) {
    board[1][1].choice();
  }
  if (full==5 && (board[1][0].checkState()==1||board[2][0].checkState()==1||board[2][1].checkState()==1)  &&
    ( board[0][1].checkState()==1||board[1][2].checkState()==1)) {
    board[2][2].choice();
  }
  if (full==5 && (board[2][2].checkState()==1||board[1][2].checkState()==1) &&
    board[0][1].checkState()==1) {
    board[2][0].choice();
  }
  if (full==5 && (board[0][2].checkState()==1||board[0][1].checkState()==1) &&
    board[1][0].checkState()==1) {
    board[2][2].choice();
  }
}


/* move of the computer(fourth one) after the third move of the player*/


void move3() {
  if (full==3 && board[2][1].checkState()==1 &&  board[0][1].checkState()==1 && (board[2][2].checkState()==1 || board[1][2].checkState()==1||board[1][0].checkState()==1) //<>//
    && board[0][2].checkState()==2 && board[1][1].checkState()==2) {
    board[2][0].choice();
  }
  if (full==3 && board[2][1].checkState()==1 &&  board[0][1].checkState()==1 && board[2][0].checkState()==1 
    && board[0][2].checkState()==2 && board[1][1].checkState()==2) {
    board[2][2].choice();
  }

  if (full==3 && (board[1][0].checkState()==1||board[2][0].checkState()==1||board[2][1].checkState()==1) &&
    ( board[0][1].checkState()==1) && board[1][2].checkState()==1  )
  {
    board[1][1].choice();
  }
  if (full==3 && (board[1][0].checkState()==1||board[2][0].checkState()==1||board[2][1].checkState()==1) &&
    ( board[0][1].checkState()==1) && board[1][1].checkState()==1  )
  {
    board[1][2].choice();
  }
  if (full==3 && (board[2][2].checkState()==1||board[1][2].checkState()==1) &&
    board[0][1].checkState()==1 && board[1][0].checkState()==1   ) {
    board[1][1].choice();
  }
  if (full==3 && (board[0][2].checkState()==1||board[0][1].checkState()==1) &&
    board[1][0].checkState()==1 && board[2][1].checkState()==1  ) {
    board[1][1].choice();
  }
  if (full==3 && (board[0][2].checkState()==1||board[0][1].checkState()==1) &&
    board[1][0].checkState()==1 && board[1][1].checkState()==1  ) {
    board[2][1].choice();
  }
  if (full==3 && board[2][2].checkState()==1 && board[0][1].checkState()==1 &&
    (board[1][1].checkState()==1 || board[2][1].checkState()==1 || board[1][2].checkState()==1 )) {
    board[1][0].choice();
  }
}



// computer play random if random=1
void move5() {




  for (int i = 0; i<cols; i++) {
    for (int j = 0; j<rows; j++) {
      board[i][j].rando(int(random(width)), int(random(height)));
    }
  }
}





void keyPressed() {
  if (game == 0) {
    if ( key == ENTER) {
      game =1; // menu
      full = 9;
    }
  } else if (game == 1) {
    scoreO=0;
    scoreX=0;
    nil=0;
    if (key=='x'||key=='X') {
      game=2; // play game 2 (one player)
      full=9;
    } else if (key=='o'||key=='O') {
      game=3; // play game 3 (2player)
      full=9;
    }
  }



  // if no one win , clean the board, click enter and replay
  else if ((game == 2|| game==3) && win == 0 && full == 0 ) {
    if ( key == ENTER) {
      stop=true;

      for (int i = 0; i<cols; i++) {
        for (int j = 0; j<rows; j++) {
          board[i][j].clean();
          win = 0;
          full = 9;
        }
      }
    }
  }
  //
  else if ( (game == 2 || game==3)&& (win == 1 || win ==2)) {
    if ( key == ENTER) {
      stop=true;

      for (int i = 0; i<cols; i++) {
        for (int j = 0; j<rows; j++) {
          board[i][j].clean();
          win = 0;
          full = 9;
        }
      }
    }
  }
  // go to the menu if you press m
  if (key=='m') {   
    game=1;
    stop=true;
    scoreX=0;
    scoreO=0;
    nil=0;
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        board[i][j].clean();
        win = 0;
        full = 9;
      }
    }
  }
}

void checkGame() {
  int row = 0;
  
  //check vertical & horizontal if someone win
  
  for (int col = 0; col< cols; col++) {
    if (board[col][row].checkState() == 1 && board[col][row+1].checkState() == 1 && board[col][row+2].checkState() == 1) {
      println("vertical 0 win!");
      win = 1;
    } else if (board[row][col].checkState() == 1 && board[row+1][col].checkState() == 1 && board[row+2][col].checkState() == 1) {
      println("Horizontal 0 win!");
      win = 1;
    } else if (board[row][col].checkState() == 2 && board[row+1][col].checkState() == 2 && board[row+2][col].checkState() == 2) {
      println("Horizontal X win!");
      win = 2;
    } else if (board[col][row].checkState() == 2 && board[col][row+1].checkState() == 2 && board[col][row+2].checkState() == 2) {
      println("vertical X win!");
      win = 2;
    }
  }

  //check diagonals
  if (board[row][row].checkState() == 1 && board[row+1][row+1].checkState() == 1 && board[row+2][row+2].checkState() == 1) {
    print(" diagonal 0 O win! ");
    win = 1;
  } else if (board[row][row].checkState() == 2 && board[row+1][row+1].checkState() == 2 && board[row+2][row+2].checkState() == 2) {
    println("diagonal 0 x win!");
    win = 2;
  } else if (board[0][row+2].checkState() == 1 && board[1][row+1].checkState() == 1 && board[2][row].checkState() == 1) {
    println("diagonal 1 O win!");
    win = 1;
  } else if (board[0][row+2].checkState() == 2 && board[1][row+1].checkState() == 2 && board[2][row].checkState() == 2) {
    println("diagonal 1 X win!");
    win = 2;
  }


  //write text
  fill(255);
  textSize(60);

  if ( win == 1 ) {
    fill(0, 0, 255);
    text("Player noughts WIN!", 150, 50);
    random=0;
  } else if ( win == 2 ) {
    fill(255, 0, 0);
    text("Player crosses WIN!", 150, 50);
    random=0;
  }




  if (win == 1 || win == 2||( win == 0 && full == 0)) {
    fill(0, 255, 0);
    textSize(35);
    text("ENTER to Start Again", width/4, height-10);
    random=0;
  }


  if ( win == 1 && stop) {

    scoreO+=1;
    stop=false;
  } else if ( win == 2 && stop) {

    scoreX+=1;
    stop=false;
  } else if (win==0 && stop && full==0) {
    nil+=1;
    stop=false;
  }
}