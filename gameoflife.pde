// 2D Array of objects
Cell[][] grid;

// Number of columns and rows in the grid
int cols = 3;
int rows = 3;

void setup() {
  size(180,180);
  int cell_width = int(width/rows);
  int cell_height = int(height/cols);
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      int init_val = int(random(0,2));
      grid[i][j] = new Cell(i*cell_height,j*cell_width,cell_height,cell_width,init_val);
    }
  }
}

void draw() {
  background(0);
  // The counter variables i and j are also the column and row numbers and
  // are used as arguments to the constructor for each object in the grid.
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].value = int(random(0,2));
      grid[i][j].display();
      
    }
  }
  delay(3000);
}


// A Cell object
class Cell {
  // A cell object knows about its location in the grid
  // as well as its size with the variables x,y,w,h
  float x,y;   // x,y location
  float w,h;   // width and height
  int value; // value for cell

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, int init_value) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    value = init_value;
  }

  void display() {
    stroke(255);
    // Color calculated using sine wave
    fill(255*value);
    rect(x,y,w,h);
  }
}
