// 2D Array of objects
Cell[][] grid;

// Number of columns and rows in the grid
int cols = 40;
int rows = 40;

void setup() {
  size(800,800);
  print("\n\n\n\n\n\n\n\n");
  print("initializing\n");
  int cell_width = int(width/rows);
  int cell_height = int(height/cols);
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      int init_val = int(random(0,2));
      grid[i][j] = new Cell(i*cell_height,j*cell_width,cell_height,cell_width,init_val);
      grid[i][j].display();
    }
  }
}

void draw() {
  background(0);
  // The counter variables i and j are also the column and row numbers and
  // are used as arguments to the constructor for each object in the grid.
  //next state
  int[][] current;
  current = new int[cols][rows];
  int[][] neighbours;
  neighbours = new int[cols][rows];
  
  //store current state
  for (int i=0; i<cols;i++) {
    for (int j=0;j<rows;j++) {
      current[i][j] = grid[i][j].value;
    }
  }
  
  //count neighbours alive
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      print("entry " + i + "," + j + "\n");
      int alive_guys = 0;
      //count neighbours
      for (int del_y=-1; del_y <= 1; del_y++) {
        for (int del_x=-1; del_x <= 1; del_x++) {
          int y_ind = (i + del_y) % (cols);
          int x_ind = (j + del_x) % (rows);
          //backwards wrapping
          if (y_ind == -1) {
             y_ind = cols-1;
          }
          
          if (x_ind == -1) {
            x_ind = rows-1;
          }
        
          alive_guys += current[y_ind][x_ind];
          print("["+y_ind+","+x_ind+"]");
        }
        print("\n");
      }
      alive_guys -= current[i][j];
      print("alive guys: "+alive_guys+"\n");
      neighbours[i][j] = alive_guys;
    }
  }
  
  //generate next state based on neighbours and current state
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      //rule 1: cell is lonely and dies
      if ((current[i][j] == 1) && (neighbours[i][j] < 2)) {
        grid[i][j].value = 0;
      } else if ((current[i][j] == 1) && (neighbours[i][j] > 3)) {
        //rule 2: overpopulation (dies) 
        grid[i][j].value = 0;
      } else if ((current[i][j] == 0) && (neighbours[i][j] == 3)) {
        //rule 3: a new cell is born
        grid[i][j].value = 1;
      } else {
        //stays the same
        grid[i][j].value = current[i][j];
      }
      grid[i][j].display();
    }
  }
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
