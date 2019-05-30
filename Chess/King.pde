public class King extends BoardItem {

  King(int rowAt, int colAt, char side) {
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
    line(cellSize/2-cellSize/10, cellSize/4-cellSize/10, cellSize/2+cellSize/10, cellSize/4-cellSize/10);
    line(cellSize/2-cellSize/10, cellSize/4-cellSize/10, cellSize/2, cellSize/4-cellSize/10*2);
    line(cellSize/2, cellSize/4-cellSize/10*2, cellSize/2+cellSize/10, cellSize/4-cellSize/10);

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
  // one in any direction
  public boolean getRange(Cell click, Board aBoard) {
    ArrayList<Cell> result = new ArrayList<Cell>();
    if (rowId-1>=0 && colId+1<8) {
      result.add(new Cell(rowId-1, colId+1));
    }
    if (rowId+1<8 && colId+1<8) {
      result.add(new Cell(rowId+1, colId+1));
    }
    if (rowId+1<8 && colId-1>=0) {
      result.add(new Cell(rowId+1, colId-1));
    }
    if (rowId-1>=0 && colId-1>=0) {     
      result.add(new Cell(rowId-1, colId-1));
    }
    if (rowId+1<8) {
      result.add(new Cell(rowId+1, colId));
    }
    if (rowId-1>=0) {
      result.add(new Cell(rowId-1, colId));
    }
    if (colId+1<8) {
      result.add(new Cell(rowId, colId+1));
    }
    if (colId-1>=0) {
      result.add(new Cell(rowId, colId-1));
    }
    if (result.contains(click)) {
      return true;
    }
    return false;
  }
}
