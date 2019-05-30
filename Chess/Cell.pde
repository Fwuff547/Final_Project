public class Cell {
  int row, col;

  public Cell(int row, int col) {
    this.row = row;
    this.col= col;
  }

  public int rowID() { 
    return row;
  }

  public int colID() { 
    return col;
  }

  public String toString() {
    return "row = " + row + ", col = " + col;
  }
  // check if occupied
  public boolean equals(Object that) {
    if (that instanceof Cell) {
      if (this.row == ((Cell)that).row && this.col == ((Cell)that).col) {
        return true;
      }
    }
    return false;
  }
}
