//Game of life implemented in javascript
//Via the p5.js library.
//Ben Cravens
var cols = 40;
var rows = 40;
var grid = createArray(cols, rows);

function setup() {
  createCanvas(400, 400);
  //initialize glider for test case
  //based on https://tinyurl.com/gliderguy
  let temp_arr = createArray(cols, rows);
  //empty screen
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      temp_arr[i][j] = 0;
    }
  }

  //draw gliders to screen
  for (let j = 0; j < rows; j += 5) {
    //initialize a bunch of gliders
    temp_arr[j + 0][2] = 1;
    temp_arr[j + 1][3] = 1;
    temp_arr[j + 2][1] = 1;
    temp_arr[j + 2][2] = 1;
    temp_arr[j + 2][3] = 1;
  }
  print("\n\n\n\n\n\n\n\n");
  print("initializing\n");
  let cell_width = width / rows;
  let cell_height = height / cols;
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      // Initialize each object
      let init_val = temp_arr[i][j];
      grid[i][j] = new Cell(
        i * cell_height,
        j * cell_width,
        cell_height,
        cell_width,
        init_val
      );
      grid[i][j].display();
    }
  }
}

function draw() {
  background(220);
  let current = createArray(cols, rows);
  let neighbours = createArray(cols, rows);

  //store current state
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      current[i][j] = grid[i][j].getval();
    }
  }

  //count neighbours alive
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      //print("entry " + i + "," + j + "\n");
      let alive_guys = 0;
      //count neighbours
      for (let del_y = -1; del_y <= 1; del_y++) {
        for (let del_x = -1; del_x <= 1; del_x++) {
          let y_ind = (i + del_y) % cols;
          let x_ind = (j + del_x) % rows;
          //backwards wrapping
          if (y_ind == -1) {
            y_ind = cols - 1;
          }

          if (x_ind == -1) {
            x_ind = rows - 1;
          }

          alive_guys += current[y_ind][x_ind];
          //print("["+y_ind+","+x_ind+"]");
        }
        //print("\n");
      }
      alive_guys -= current[i][j];
      //print("alive guys: "+alive_guys+"\n");
      neighbours[i][j] = alive_guys;
    }
  }

  //generate next state based on neighbours and current state
  //print("Calculating next gen based on rules");
  //generate next state based on neighbours and current state
  for (let i = 0; i < cols; i++) {
    for (let j = 0; j < rows; j++) {
      //rule 1: cell is lonely and dies
      if ((current[i][j] == 1) && (neighbours[i][j] < 2)) {
        grid[i][j].setval(0);
      } else if ((current[i][j] == 1) && (neighbours[i][j] > 3)) {
        //rule 2: overpopulation (dies) 
        grid[i][j].setval(0);
      } else if ((current[i][j] == 0) && (neighbours[i][j] == 3)) {
        //rule 3: a new cell is born
        grid[i][j].setval(1);
      } else {
        //stays the same
        grid[i][j].setval(current[i][j]);
      }
      grid[i][j].display();
    }
  }
}

//function to make 2d-arrays
function createArray(length) {
  var arr = new Array(length || 0),
    i = length;

  if (arguments.length > 1) {
    var args = Array.prototype.slice.call(arguments, 1);
    while (i--) arr[length - 1 - i] = createArray.apply(this, args);
  }

  return arr;
}

//cell class
//a cell object knows its location in the grid
//as well as its size.
class Cell {
  constructor(init_x, init_y, init_w, init_h, init_val) {
    this.x = init_x;
    this.y = init_y;
    this.w = init_w;
    this.h = init_h;
    this.val = init_val;
  }

  //get value method
  getval() {
    return this.val;
  }
  
  //value setter method
  setval(inval) {
    this.val = inval;
  }
  
  display() {
    stroke(255);
    fill(255 * this.val);
    rect(this.x, this.y, this.w, this.h);
  }
}
