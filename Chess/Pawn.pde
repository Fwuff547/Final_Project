public class Pawn extends BoardItem {

  Pawn(int rowAt, int colAt, char side) {
    super(rowAt, colAt, side);
    selected = false;
  }

  public void show(int xAt, int yAt, int cellSize) {
    pushMatrix();
    translate(xAt, yAt);
    strokeWeight(4);
    //legs
    line( cellSize/3, cellSize, cellSize/2, 2*cellSize/3);
    line( 2*cellSize/3, cellSize, cellSize/2, 2*cellSize/3);

    //body
    line( cellSize/2, 2*cellSize/3, cellSize/2, cellSize/4+cellSize/10);

    //head
    noFill();
    ellipse(cellSize/2, cellSize/4, .2*cellSize, .2*cellSize);

    //arms
    line( cellSize/4, cellSize/2, 3*cellSize/4, cellSize/2);
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
  // one or two forward
  public boolean getRange(Cell click, Board aBoard) {
    boolean empty = true;
    ArrayList<Cell> result = new ArrayList<Cell>();
    if (side == 'b') {
      if (rowId==1) {
        result.add(new Cell(2, colId));
        for (BoardItem b : aBoard.items) {
          if (b.row() == 2 && b.col()==colId) {
            empty = false;
          }
        }
        if (empty) {
          result.add(new Cell(3, colId));
        }
      } else {
        result.add(new Cell(rowId+1, colId));
      }
    }
    if (side == 'w') {
      if (rowId==6) {
        result.add(new Cell(5, colId));
        for (BoardItem b : aBoard.items) {
          if (b.row() == 5 && b.col()==colId) {
            empty = false;
          }
        }
        if (empty) {
          result.add(new Cell(4, colId));
        }
      } else {
        result.add(new Cell(rowId-1, colId));
      }
    }
    if (result.contains(click)) {
      return true;
    }
    return false;
  }
  // one diagonal
  public boolean atkRange(Cell click) {
    ArrayList<Cell> result = new ArrayList<Cell>();
    if (side == 'b') {
      if (rowId+1<8 && colId+1<8) {
        result.add(new Cell(rowId+1, colId+1));
      }
      if (rowId+1<8 && colId-1>=0) {
        result.add(new Cell(rowId+1, colId-1));
      }
    }
    if (side == 'w') {
      if (rowId-1>=0 && colId+1<8) {
        result.add(new Cell(rowId-1, colId+1));
      }
      if (rowId-1>=0 && colId-1>=0) {
        result.add(new Cell(rowId-1, colId-1));
      }
    }
    if (result.contains(click)) {
      return true;
    }
    return false;
  }
}
