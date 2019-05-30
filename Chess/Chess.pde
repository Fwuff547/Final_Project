int wturn, pressed, ene;
Board theBoard;
BoardItem item1;
BoardItem p;
Cell clicked;
boolean endb, endw, checkb, checkw;

void setup() {
  size(800, 800);
  theBoard = new Board(0, 0, 8, 8, height/8);
  clicked = new Cell(20, 20);
  endb = false;
  endw = false;
  checkb = false;
  checkw = false;
  // initial piece setup
  for (int i = 0; i<8; i++) {
    theBoard.addItem( new Pawn(1, i, 'b') );
    theBoard.addItem( new Pawn(6, i, 'w') );
  }
  theBoard.addItem( new Bishop(0, 2, 'b') );
  theBoard.addItem( new Bishop(0, 5, 'b') );
  theBoard.addItem( new Bishop(7, 2, 'w') );
  theBoard.addItem( new Bishop(7, 5, 'w') );
  theBoard.addItem( new Rook(0, 0, 'b') );
  theBoard.addItem( new Rook(0, 7, 'b') );
  theBoard.addItem( new Rook(7, 0, 'w') );
  theBoard.addItem( new Rook(7, 7, 'w') );
  theBoard.addItem( new Knight(0, 1, 'b') );
  theBoard.addItem( new Knight(0, 6, 'b') );
  theBoard.addItem( new Knight(7, 1, 'w') );
  theBoard.addItem( new Knight(7, 6, 'w') );
  theBoard.addItem( new Queen(7, 3, 'w') );
  theBoard.addItem( new Queen(0, 3, 'b') );
  theBoard.addItem( new King(7, 4, 'w') );
  theBoard.addItem( new King(0, 4, 'b') );

  wturn = 1;
  pressed = 0;
  ene = -1;
}

void draw() {
  background(255);
  theBoard.show();
  int rem = -1;
  int ro = -1;
  int co = -1;
  for (BoardItem b : theBoard.items) {
    // pawn to queen if it reaches the other side
    if (b instanceof Pawn) {
      if (b.side == 'w') {
        if (b.row() == 0) {
          rem = theBoard.items.indexOf(b);
          ro = b.row();
          co = b.col();
        }
      }
      if (b.side == 'b') {
        if (b.row() == 0) {
          rem = theBoard.items.indexOf(b);
          ro = b.row();
          co = b.col();
        }
      }
    }
    // checkmate???
    if (b instanceof King) {
      int wcheckmate = 0;
      int bcheckmate = 0;
      // array of avalible spaces to move
      ArrayList<Cell> avalible = new ArrayList<Cell>();
      if (b.getRange(new Cell(b.row()+1, b.col()), theBoard)) {
        avalible.add(new Cell(b.row()+1, b.col()));
      }
      if (b.getRange(new Cell(b.row()+1, b.col()+1), theBoard)) {
        avalible.add(new Cell(b.row()+1, b.col()+1));
      }
      if (b.getRange(new Cell(b.row()-1, b.col()), theBoard)) {
        avalible.add(new Cell(b.row()-1, b.col()));
      }
      if (b.getRange(new Cell(b.row()+1, b.col()-1), theBoard)) {
        avalible.add(new Cell(b.row()+1, b.col()-1));
      }
      if (b.getRange(new Cell(b.row()-1, b.col()-1), theBoard)) {
        avalible.add(new Cell(b.row()-1, b.col()-1));
      }
      if (b.getRange(new Cell(b.row()-1, b.col()+1), theBoard)) {
        avalible.add(new Cell(b.row()-1, b.col()+1));
      }
      if (b.getRange(new Cell(b.row(), b.col()-1), theBoard)) {
        avalible.add(new Cell(b.row(), b.col()-1));
      }
      if (b.getRange(new Cell(b.row(), b.col()+1), theBoard)) {
        avalible.add(new Cell(b.row(), b.col()+1));
      }
      for (int i = avalible.size()-1; i>=0; i--) {
        Cell avspace = avalible.get(i);
        for (BoardItem j : theBoard.items) {
          if (j.side == b.side && j.col() == avspace.colID() && j.row()== avspace.rowID()) {
            avalible.remove(i);
          }
        }
      }
      avalible.add(new Cell(b.row(), b.col()));
      for (Cell c : avalible) {
        for (BoardItem check : theBoard.items) {
          if (check.side != b.side) {
            if (check instanceof Pawn && check.atkRange(c)) {
              if (b.side == 'b') {
                bcheckmate++;
                break;
              }
              if (b.side == 'w') {
                wcheckmate++;
                break;
              }
            } else {
              if (check.getRange(c, theBoard)) {
                if (b.side == 'b') {
                  bcheckmate++;
                  break;
                }
                if (b.side == 'w') {
                  wcheckmate++;
                  break;
                }
              }
            }
          }
        }
      }
      //checking if in checkmate
      if (bcheckmate == avalible.size()&& avalible.size()>0) {
        endb = true;
      }
      if (wcheckmate == avalible.size()&& avalible.size()>0) {
        endw = true;
      }
      //determining if in check
      if(bcheckmate>1) {
        checkb = true;
      }
      if(wcheckmate>1) {
        checkw = true;
      }
      
    }
  }
  if (rem != -1 && ro != -1 && co != -1) {
    theBoard.items.remove(rem);
    if (ro ==0) {
      theBoard.addItem( new Queen(ro, co, 'w') );
    }
    if (ro ==7) {
      theBoard.addItem( new Queen(ro, co, 'b') );
    }
    rem = -1;
    ro = -1;
    co = -1;
  }
  // determining who won
  if (endb) {
    theBoard.items.clear();
    fill(0);
    rect(0, 0, width, height);
    fill(0, 102, 153);
    textSize(32);
    text("Checkmate, white wins", width/2-130, height/2);
  }
  if (endw) {
    theBoard.items.clear();
    fill(0);
    rect(0, 0, width, height);
    fill(0, 102, 153);
    textSize(32);
    text("Checkmate, black wins", width/2-130, height/2);
  }
}

void mousePressed() {
  clicked = theBoard.getCell(mouseX, mouseY);
  boolean empty = true;
  ene = -1;

  for (BoardItem b : theBoard.items) {
    if (clicked.rowID() == b.row() && clicked.colID() == b.col()) {
      empty = false;
    }
  }
  // select piece to move
  for (BoardItem b : theBoard.items) {
    if (pressed<=1&&clicked.rowID() == b.row() && clicked.colID() == b.col()) {
      if (b.side == 'w' && wturn == 1) {
        for (BoardItem i : theBoard.items) {
          if (i.selected) {
            i.selected = false;
          }
        }
        b.selected = true;
        pressed  = 1;
      }
      if (b.side == 'b' && wturn == -1) {
        for (BoardItem i : theBoard.items) {
          if (i.selected) {
            i.selected = false;
          }
        }
        b.selected = true;
        pressed  = 1;
      }
    }
    //move the piece
    if (pressed ==1 && b.selected == true && (b.getRange(clicked, theBoard)||b.atkRange(clicked))) {
      if (empty) {
        if (!(b instanceof Pawn)) {
          b.updateRow(clicked.rowID());
          b.updateCol(clicked.colID());
          pressed  = 2;
        }
        // pawns can attack diagonally but only move vertically normally
        if (b instanceof Pawn && b.getRange(clicked, theBoard)) {
          println("moved");
          b.updateRow(clicked.rowID());
          b.updateCol(clicked.colID());
          pressed  = 2;
        }
      } else {
        for (BoardItem e : theBoard.items) {
          if (clicked.rowID() == e.row() && clicked.colID() == e.col() && !(e instanceof King)) {
            if (b.side != e.side && !(b instanceof Pawn)) {
              ene = theBoard.items.indexOf(e);
              println("moved");
              b.updateRow(clicked.rowID());
              b.updateCol(clicked.colID());
              pressed  = 2;
            }
            if (b.side != e.side && b instanceof Pawn && b.atkRange(clicked)) {
              ene = theBoard.items.indexOf(e);
              println("moved");
              b.updateRow(clicked.rowID());
              b.updateCol(clicked.colID());
              pressed  = 2;
            }
          }
        }
      }
    }
  }
  if (ene !=-1) {
    theBoard.delItem(ene);
  }
  if (pressed ==2) {
    wturn = wturn*-1;
    pressed  = 0;
  }
  for (BoardItem b : theBoard.items) {
    if (pressed<1) {
      b.selected = false;
    }
  }
}

void keyPressed() {
  //reset the game
  theBoard.items.clear();
  endw= false;
  endb = false;
  checkb = false;
  checkw = false;
  theBoard = new Board(0, 0, 8, 8, height/8);
  clicked = new Cell(20, 20);
  // initial piece setup
  for (int i = 0; i<8; i++) {
    theBoard.addItem( new Pawn(1, i, 'b') );
    theBoard.addItem( new Pawn(6, i, 'w') );
  }
  theBoard.addItem( new Bishop(0, 2, 'b') );
  theBoard.addItem( new Bishop(0, 5, 'b') );
  theBoard.addItem( new Bishop(7, 2, 'w') );
  theBoard.addItem( new Bishop(7, 5, 'w') );
  theBoard.addItem( new Rook(0, 0, 'b') );
  theBoard.addItem( new Rook(0, 7, 'b') );
  theBoard.addItem( new Rook(7, 0, 'w') );
  theBoard.addItem( new Rook(7, 7, 'w') );
  theBoard.addItem( new Knight(0, 1, 'b') );
  theBoard.addItem( new Knight(0, 6, 'b') );
  theBoard.addItem( new Knight(7, 1, 'w') );
  theBoard.addItem( new Knight(7, 6, 'w') );
  theBoard.addItem( new Queen(7, 3, 'w') );
  theBoard.addItem( new Queen(0, 3, 'b') );
  theBoard.addItem( new King(7, 4, 'w') );
  theBoard.addItem( new King(0, 4, 'b') );

  wturn = 1;
  pressed = 0;
  ene = -1;
}
