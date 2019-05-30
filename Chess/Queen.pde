public class Queen extends BoardItem {

  Queen(int rowAt, int colAt, char side) {
    super(rowAt, colAt, side);
    selected = false;
  }

  public void show(int xAt, int yAt, int cellSize) {
    pushMatrix();
    translate(xAt, yAt);
    strokeWeight(4);
    //legs
    line( cellSize/3, cellSize, cellSize/2, cellSize/2);
    line( 2*cellSize/3, cellSize, cellSize/2, cellSize/2);

    //body
    line( cellSize/2, cellSize/2, cellSize/2, cellSize/4+cellSize/10);

    //head
    noFill();
    ellipse(cellSize/2, cellSize/4, .2*cellSize, .2*cellSize);
    line(cellSize/2-cellSize/10, cellSize/4-cellSize/10, cellSize/2+cellSize/10, cellSize/4-cellSize/10);
    line(cellSize/2-cellSize/10, cellSize/4-cellSize/10, cellSize/2, cellSize/4-cellSize/10*2);
    line(cellSize/2, cellSize/4-cellSize/10*2, cellSize/2+cellSize/10, cellSize/4-cellSize/10);


    //arms
    line( cellSize/4, cellSize/2, 3*cellSize/4, cellSize/2);
    line( 3*cellSize/4, cellSize/1.75, 3*cellSize/4, cellSize/8);
    if (side == 'b') {
      ellipse(cellSize/6, cellSize/8, 5, 5);
    }
    if (selected) {
      stroke(#0B9D1B);
      ellipse(5*cellSize/6, cellSize/8, 5, 5);
      stroke(0);
    }
    popMatrix();
  }
  // diagonal, horizontal, or vertical
  public boolean getRange(Cell click, Board aBoard) {
    ArrayList<Cell> result = new ArrayList<Cell>();
    for (int i = 1; rowId-i>=0; i++) {
      result.add(new Cell(rowId-i, colId));
      boolean empty = true;
      for (BoardItem b : aBoard.items) {
        if (b.row()==rowId-i&& b.col() == colId) {
          empty = false;
        }
      }
      if (!empty) {
        break;
      }
    }
    for (int i = 1; rowId+i<8; i++) {
      result.add(new Cell(rowId+i, colId));
      boolean empty = true;
      for (BoardItem b : aBoard.items) {
        if (b.row()==rowId+i&& b.col() == colId) {
          empty = false;
        }
      }
      if (!empty) {
        break;
      }
    }
    for (int i = 1; colId+i<8; i++) {
      result.add(new Cell(rowId, colId+i));
      boolean empty = true;
      for (BoardItem b : aBoard.items) {
        if (b.row()==rowId&& b.col() == colId+i) {
          empty = false;
        }
      }
      if (!empty) {
        break;
      }
    }
    for (int i = 1; colId-i>=0; i++) {
      result.add(new Cell(rowId, colId-i));
      boolean empty = true;
      for (BoardItem b : aBoard.items) {
        if (b.row()==rowId&& b.col() == colId-i) {
          empty = false;
        }
      }
      if (!empty) {
        break;
      }
    }
    for (int i = 1; i<8; i++) {
      if (rowId-i>=0 && colId+i<8) {
        result.add(new Cell(rowId-i, colId+i));
        boolean empty = true;
        for (BoardItem b : aBoard.items) {
          if (b.row()==rowId-i&& b.col() == colId+i) {
            empty = false;
          }
        }
        if (!empty) {
          break;
        }
      }
    }
    for (int i = 1; i<8; i++) {
      if (rowId+i<8 && colId-i>=0) {
        result.add(new Cell(rowId+i, colId-i));
        boolean empty = true;
        for (BoardItem b : aBoard.items) {
          if (b.row()==rowId+i&& b.col() == colId-i) {
            empty = false;
          }
        }
        if (!empty) {
          break;
        }
      }
    }
    for (int i = 1; i<8; i++) {
      if (rowId-i>=0 && colId-i>=0) {
        result.add(new Cell(rowId-i, colId-i));
        boolean empty = true;
        for (BoardItem b : aBoard.items) {
          if (b.row()==rowId-i&& b.col() == colId-i) {
            empty = false;
          }
        }
        if (!empty) {
          break;
        }
      }
    }
    for (int i = 1; i<8; i++) {
      if (rowId+i<8 && colId+i<8) {
        result.add(new Cell(rowId+i, colId+i));
        boolean empty = true;
        for (BoardItem b : aBoard.items) {
          if (b.row()==rowId+i&& b.col() == colId+i) {
            empty = false;
          }
        }
        if (!empty) {
          break;
        }
      }
    }

    if (result.contains(click)) {
      return true;
    }
    return false;
  }
}
