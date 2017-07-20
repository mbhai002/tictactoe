//CELL CLASS
 
class Cell {
  int x;
  int y ;
  int w;
  int h;
  int state = 0;
 
  Cell(int tx, int ty, int tw, int th) {
    x = tx;
    y = ty;
    w = tw;
    h = th;
  } 
 
  // if the player click on the square; then the state 1 or 2 draw a circle or cross. and the number of empty square(full) decrease, and the player change

  void click(int tx, int ty) {
   
    if (tx > x && tx < x+w && ty > y && ty < y+h) {
 
      if (player == 0 && state == 0 ) {
        state = 1;
        full -= 1;
        player = 1;
      }
     else if (player == 1 && state == 0 ) {
       state = 2;
        full -= 1;
        player = 0;
      }
    }
 
}

//same of void click  but for when the computer play randomly

void rando(int tx, int ty){
  
  
  if( int(tx)>x && int(tx) < x+w && int(ty)  > y && int(ty) < y+h){
    if (player==1 && state==0){
    state=2;
    full -= 1;
    player=0;
  }
  }
}  
// when the computer plays by the algorithm
    void choice(){
      state=2;
      full-=1;
      player=0;
     
    }
  
  // clean the board   
  void clean(){
    state = 0; 
  }
   
  int checkState(){
    return state; 
  }

  
  // draw the rectagle to make a board , and the circle and cross
void display(){
  noFill();
  stroke(255);
    strokeWeight(3);
    rect(x, y, w, h); //draw Cell with the constructor 
    if (state == 1) {  // if state=1 draw circle
      ellipseMode(CORNER);
      stroke(0, 0, 255);
      strokeWeight(20);
      ellipse(x, y, w, h);
    }
    else if ( state == 2) { // if state =2 draw cross
      stroke(255, 0, 0);
            strokeWeight(20);

      line(x, y, x+w, y+h);
      line(x+w, y, x, y+h);
    }
  }
}