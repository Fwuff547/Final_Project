public class BoardItem {

  //Where the board item upper left/right corner lives
  int colId, rowId;

  //TODO: This might not be the best way to track
  //but we need to know when we are out of bounds
  protected int maxRow, maxCol;
  boolean selected;
  char side;

  protected int[][] glyphData;

  public BoardItem(int rowAt, int colAt, char side) {
    this.rowId = rowAt;
    this.colId = colAt;
    this.side = side;
    selected = false;
  }

  public void setData(int[][] data) {
    glyphData = data;
  }

  public int row() { 
    return rowId;
  }

  public int col() { 
    return colId;
  }

  public void show(int xAt, int yAt, int cellSize) {    
    for (int row = 0; row < glyphData.length; row++) {
      for (int col = 0; col < glyphData[row].length; col++) {
        int fillColor = glyphData[row][col];
        if (fillColor > -1) {
          fill(fillColor);
          int x = xAt + col*cellSize;
          int y = yAt + row*cellSize;
          rect(x, y, cellSize, cellSize);
        }
      }
    }
  }

  public void setBounds(int rows, int cols) {
    maxRow = rows;
    maxCol = cols;
  }

  public void updateCol(int by) {
    colId = by;
  }

  public void updateRow(int by) {
    rowId = by;
  }
  // what spaces a piece can move: diagonal, horizontal, vertical, etc...
  public boolean getRange(Cell click, Board aBoard) {
    ArrayList<Cell> result = new ArrayList<Cell>();

    //deal with the up direction
    if (side == 'u') {
      for (int i = 0; i < glyphData[0].length; i++) {
        if ( glyphData[0][i] > -1 ) {
          int colVal = i + colId;
          int rowVal = rowId - 1;
          Cell c = new Cell(rowVal, colVal);
          result.add(c);
        }
      }
    }

    return false;
  }
  //pawn only attacks diagonally otherwise not standard move
  public boolean atkRange(Cell click) {
    ArrayList<Cell> result = new ArrayList<Cell>();

    //deal with the up direction
    if (side == 'u') {
      for (int i = 0; i < glyphData[0].length; i++) {
        if ( glyphData[0][i] > -1 ) {
          int colVal = i + colId;
          int rowVal = rowId - 1;
          Cell c = new Cell(rowVal, colVal);
          result.add(c);
        }
      }
    }

    return false;
  }
}
