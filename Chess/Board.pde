public class Board {

  int x_pos, y_pos;  
  int cellSize;
  int rows, cols;
  int[][] layer;
  ArrayList<BoardItem> items;
  int side;

  public Board(int x, int y, int numRows, int numCols, int cellSize ) {
    x_pos = x;
    y_pos = y;
    this.cellSize = cellSize;
    rows = numRows;
    cols = numCols;
    layer = null;
    items = new ArrayList<BoardItem>();
    side = 1;
  }
  //adding pieces
  public void addItem(BoardItem item) {
    items.add(item); 
    item.setBounds(rows, cols);
  }
  //piece captured
  public void delItem(int index) {
    items.remove(index);
  }

  public void show() {
    pushMatrix();
    translate(x_pos, y_pos);
    for (int j=0; j< rows; j++) {
      side = j%2;
      for (int i=0; i < cols; i++) {
        int xAt = i*cellSize;
        int yAt = j*cellSize;

        //todo: think about what color we want
        //fill( ? )
        //stroke( ? ) //border color
        //strokeWeight( ? ) // thickness of cell border
        if (side%2==1) {
          fill(255);
        } else {
          fill(100);
        }
        side++;
        rect(xAt, yAt, cellSize, cellSize);
        drawLayerCell(j, i, xAt, yAt);
      }
    }

    //Draw each item on the board
    for (BoardItem item : items) {
      int xAt = item.col()*cellSize;
      int yAt = item.row()*cellSize;
      item.show(xAt, yAt, cellSize);
    }    

    popMatrix();
  }  

  protected void drawLayerCell(int rowId, int colId, int xPos, int yPos) {
    if (layer != null) {
      if (layer.length > rowId) {
        if (layer[rowId].length > colId) {
          int cellColor = layer[rowId][colId];
          fill(cellColor);
          rect(xPos, yPos, cellSize, cellSize);
        }
      }
    }
  }

// indentify where one has clicked for selection, movement, and attacking
  public Cell getCell(int xClicked, int yClicked) {
    xClicked = xClicked - x_pos;
    yClicked = yClicked - y_pos;

    int xAt = xClicked/cellSize;
    int yAt = yClicked/cellSize;

    return new Cell(yAt, xAt);
  }

  public void addLayer(int[][] theLayer) {
    this.layer = theLayer;
  }
}
