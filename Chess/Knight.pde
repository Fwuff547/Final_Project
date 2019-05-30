public class Knight extends BoardItem {

  Knight(int rowAt, int colAt, char side) {
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
  // two straight then one to the side
  public boolean getRange(Cell click, Board aBoard) {
    ArrayList<Cell> result = new ArrayList<Cell>();
    if (rowId+2<8) {
      if (colId+1<8) {
        result.add(new Cell(rowId+2, colId+1));
      }
      if (colId-1>=0) {
        result.add(new Cell(rowId+2, colId-1));
      }
    }
    if (rowId-2>=0) {
      if (colId+1<8) {
        result.add(new Cell(rowId-2, colId+1));
      }
      if (colId-1>=0) {
        result.add(new Cell(rowId-2, colId-1));
      }
    }
    if (colId+2<8) {
      if (rowId+1<8) {
        result.add(new Cell(rowId+1, colId+2));
      }
      if (rowId-1>=0) {
        result.add(new Cell(rowId-1, colId+2));
      }
    }
    if (colId-2>=0) {
      if (rowId+1<8) {
        result.add(new Cell(rowId+1, colId-2));
      }
      if (rowId-1>=0) {
        result.add(new Cell(rowId-1, colId-2));
      }
    }
    if (result.contains(click)) {
      return true;
    }
    return false;
  }
}
