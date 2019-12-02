// Game:     Four in a Row 
// Created:  2019/12/02 creation date]
// Author:   Juan Gestal (juan@gestal.es)
//

int w = 7;
int h = 6;
int bs = 100;
int player = 1;
int[][] board = new int[w][h];
int state;

void setup() {
  size(701,601);
  ellipseMode(CORNER);
  textSize(32);
  textAlign(CENTER, CENTER);
}

void reset() {
    for (int c = 0; c < w; c++) for (int r = 0; r < h; r++) {
      board[c][r] = 0;
    }
    state = 0;
    player = 1;
}

void draw() {  
  for (int c = 0; c < w; c++) for (int r = 0; r < h; r++) {
    fill(255); 
    rect(c*bs,r*bs,bs,bs);
    if (board[c][r] > 0) {
      fill(board[c][r] == 1?255:0,0,board[c][r]==2?255:0);
      ellipse(c*bs,r*bs,bs,bs);
    }
  }
  
  if (state != 0) {
    textAlign(CENTER, CENTER);
    String s = "";
    if (state == -1) s = "Draw game. ";
    else if (state == 1) s = "Player 1 Wins. ";
    else if (state == 2) s = "Player 2 Wins. ";  
    rect(width/2 - 5*bs, height/2 - bs, 10*bs, 2*bs);
    fill(0);
    text(s + "Press click to restart.", width/2, height/2);
  }
}

void mousePressed() {
  int c = int(mouseX / bs);
  c = c < w * bs ? c : w * bs;
  int r = nextSpace(c);
  
  if (state == 0) {
    if (r >= 0) {
      board[c][r] = player;
      player = player == 1 ? 2 : 1;
      state = getState();
    }
    //print("Col: " + c + " Row: " + r + " State: " + state + "\n");  
  }
  else {
    reset();
  }
}

int nextSpace(int c) {
  for (int r = h - 1; r >= 0; r--) {
    if (board[c][r] == 0) return r;
  }
  return -1;
}

int f(int c, int r) { 
  return (c < 0 || r < 0 || c >= w || r >= h) ? 0 : board[c][r]; 
}

// -1: Draw
// 0: Empty Fields
// 1: Player 1 Wins
// 2: Player 2 Wins

int getState() {
  int emptyFields = 0;
    for (int c = 0; c < w; c++) for (int r = 0; r < h; r++) {
      int val = board[c][r];
      if (val > 0) {
        // Horizontal          
        if (val == f(c+1,r) && val == f(c+2,r) && val == f(c+3,r)) {
          return val;
        }
        // Vertical
        if (val == f(c,r+1) && val == f(c,r+2) && val == f(c,r+3)) {
          return val;
        }
        // Diagonals
        if (val == f(c+1,r+1) && val == f(c+2,r+2) && val == f(c+3,r+3)) {
          return val;
        }
        if (val == f(c+1,r-1) && val == f(c+2,r-2) && val == f(c+3,r-3)) {
          return val;
        }
      } else {
        emptyFields++;
      }
    }
  return emptyFields > 0 ? 0 : -1;
}
