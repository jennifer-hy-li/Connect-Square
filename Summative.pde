//GAME
  int level = 1;
  int levelGoal = 20+ level*10;
  PFont Font;
  PFont Control;
  //screen case;
  int screen = 1;
  int reset = 0;
  //theme case
  int theme = 1;

//MAIN PAGE
  PImage background;
  
  //buttons
  color buttons = color(48, 91, 160);
  color buttonClicked = color(61, 14, 86);
  int mpButtonWidth = 400;
  int mpButtonHeight = 70;
  
  //how to play button
  int HTPX, HTPY;
  
  //theme button
  int ThemeX, ThemeY;
  
  //settings button
  int SettingsX, SettingsY;

//THEME
  //ball variable
  int ballX = 37;
  int ballY = 162;

//PLAYING SCREEN
  //background
  PImage playBackground;
  PImage Theme2;
  PImage Theme3;
  PImage Theme4;
  
  
  //grid drawing variables
  int gridX;
  int gridY;
  int gridWidth;
  int gridHeight;
  int gridUnit = 30;
  
  
  
  //tetris preview piece location variables
  color ColorPiece1;
  color ColorPiece2;
  color PreviewPiece;
  int shapeX = 150;
  int shapeY = 100;
  int preview = 2;
  String shape= "L";

  //time variables
  //decreasing timer
  float time = 10;
  //amount of times the timer resets from 0
  int Zeroes = 0;

  //win loose variable
  int score = 0;

//tetris piece class


// int[][] grid = new int[cols][rows];
//collision grid variables
int collisionGridCols = 10;
int collisionGridRows = 20;
boolean[][] grid = new boolean[collisionGridCols][collisionGridRows]; // collision grid

//Tetris Piece Placed
class TetrisPiece {
    int x;
    int y;
    color pieceColor;
    
    TetrisPiece(color tempColor, int tempX, int tempY){
      pieceColor = tempColor;
      x = tempX;
      y = tempY;
    }
    //the game uses this grid to determine where a shape can be placed and where it can't
    // type     function name   parameters
    boolean[][] fillGrid(boolean[][] tempGrid, String shape){
        // convert the x value to the collision grid index
        // same with y
        int xIndex = (x - 150)/30;
        int yIndex = (y - 100)/30;
        
        fill(pieceColor);
        switch(shape){
          //if the shape is a spuare, make the units of the square true
          case "square":
            // access and fill grid
            tempGrid[xIndex][yIndex] = true;
            tempGrid[xIndex][yIndex + 1] = true;
            tempGrid[xIndex + 1][yIndex] = true;
            tempGrid[xIndex + 1][yIndex + 1] = true;
          case "L":
          //if the shape is L, make the units of the L true
            tempGrid[xIndex][yIndex] = true;
            tempGrid[xIndex][yIndex + 1] = true;
            tempGrid[xIndex + 1][yIndex + 1] = true;
        } 

        return tempGrid;
    }

}
//set all units of the collision grid to false
boolean[][] resetGrid(boolean[][] tempGrid){
    for (int i = 0; i < collisionGridRows; i++) {
        for (int j = 0; j < collisionGridCols; j++) {
            tempGrid[j][i] = false;
        }
    }
    return tempGrid;
}

void setup(){
//SETUP
  size(600, 800);
  //framerate
  frameRate(20);
  //fonts 
  Control = createFont("Control.ttf", 50);
  Font = createFont("Font.ttf", 65);
  
//MAIN PAGE
  //background
  background = loadImage("building.jpg");
  background.resize(900, 1000);
    
  //how to play button 
  HTPX = 100;
  HTPY = 400;
  
  //theme button
  ThemeX = 100;
  ThemeY = 500;
  
  //settings button;
  SettingsX = 100;
  SettingsY = 600;
//PLAY
  //Theme1
  playBackground = loadImage("play.jpg");
  playBackground.resize(900, 800);
 
  //Theme2
  Theme2 = loadImage("Theme2.jpg");
   Theme2.resize(900, 800);
  
  //Theme3
  Theme3 = loadImage("Theme3.jpg");
  Theme3.resize(700, 800);
  
  //Theme4
  Theme4 = loadImage("Theme4.jpg");
  Theme4.resize(900, 800);

  //sets the collision grid to all false (nothing is placed yet, a shape could be placed any where on the grid)
  grid = resetGrid(grid);
}

void draw(){
  //switching screens
  switch(screen){
    case 1:
    Home();
    break;
    
    case 2:
    HTP();
    break;
    
    case 3:
    Theme();
    break;
    
    case 4:
    Settings();
    break;
    
    case 5:
    Play();
    break;
    
    case 6:
    Lose();
    break;
    
    case 7:
    Win();
    break;
    
  }
}

void mouseClicked(){
//MAIN PAGE
  //HOW TO PLAY
  //Main menu -> how to play
  if (screen == 1 && mouseX >= HTPX && mouseX<= HTPX + mpButtonWidth && mouseY >= HTPY && mouseY <= HTPY + mpButtonHeight){
    screen = 2;
  }
    //How to Play-> playing screen
    if (screen == 2 && mouseX >= 400 && mouseX<= 400 + 150 && mouseY >= 700 && mouseY <= 700 + 50){
      screen = 5;
    }
  //main menu-> theme()
  if (screen == 1 && mouseX >= ThemeX && mouseX<= ThemeX + mpButtonWidth && mouseY >= ThemeY && mouseY <= ThemeY + mpButtonHeight){
    screen = 3;
  }
    //Theme-> main menu
  if (screen == 3 && mouseX >= 30 && mouseX<= 30 + 100 && mouseY >= 50 && mouseY <= 50 + 50){
    screen = 1;
  }
    //theme() slider
    if (screen == 3 && mouseX >=25 && mouseX <= 25 + 550 && mouseY >= 150 && mouseY <= 150 +25){
    ballX = mouseX;
  }
  
  //main menu-> settings()
  if (screen == 1 && mouseX >= SettingsX && mouseX<= SettingsX + mpButtonWidth && mouseY >= SettingsY && mouseY <= SettingsY + mpButtonHeight){
    screen = 4;
  }
  
  if (screen == 7 && mouseX >= 50 && mouseX<= 50 + 100 && mouseY >= 50 && mouseY <= 50+ 50){
   screen = 1; 
   Zeroes = 0;
    time = 10;
    grid = resetGrid(grid);
    shapeX = 150;
    shapeY= 100;
    levelGoal = 30;
  }
  
}
//screen 1 aka main menu
void Home(){
//BACKGROUND
  tint(255);
  image(background, 0, 0);
  
//HOW TO PLAY BUTTON
  //change colors of button when mouse hovers over it
  if (screen == 1 && mouseX >= HTPX && mouseX<= HTPX + mpButtonWidth && mouseY >= HTPY && mouseY <= HTPY + mpButtonHeight){
    stroke(buttons, 0);
    fill(buttons, 200);
  }
  else{ 
    stroke(buttons, 0);
    fill(buttons, 150);
  }
  rect(HTPX, HTPY, mpButtonWidth, mpButtonHeight);
  
//THEME BUTTON
//change colors of button when mouse hovers over it
  if (screen == 1 && mouseX >= ThemeX && mouseX<= ThemeX + mpButtonWidth && mouseY >= ThemeY && mouseY <= ThemeY + mpButtonHeight){
    stroke(buttons, 0);
    fill(buttons, 200);
  }
  else{ 
    stroke(buttons, 0);
    fill(buttons, 150);
  }
  rect(ThemeX, ThemeY, mpButtonWidth, mpButtonHeight);
  
//SETTINGS BUTTON
//change colors of button when mouse hovers over it
  if (screen == 1 && mouseX >= SettingsX && mouseX<= SettingsX + mpButtonWidth && mouseY >= SettingsY && mouseY <= SettingsY + mpButtonHeight){
    stroke(buttons, 0);
    fill(buttons, 200);
  }
  else{ 
    stroke(buttons, 0);
    fill(buttons, 150);
  }
  rect(SettingsX, SettingsY, mpButtonWidth, mpButtonHeight);

//FONT/TEXT
  textFont(Font);
  
  //Title
  fill(33, 5, 117);
  text("Connect Square", 0, 300);
  
  //How to play button
  textSize(30);
  fill(250);
  text("How to Play", 180, 445);
  
  //Theme button
  text("Theme", 250, 545);
  
  //Settings button
  text("Settings", 225, 650);
  
}
//screen 2
void HTP(){
  //background
  background(30, 53, 91);
  textSize(15);
  fill(250,250,250);
  //Instructions
  text("Congratulations!! You just graduated from college", 0, 30);
  text("and already found a job downtown.The problem is", 0, 60);
  text("your mom keeps nagging you to move out. ", 0, 90);
  text("Your solution? Build your own apartment complex. ", 0, 120);
  text("Fill a row in the grid with shapes to add one ", 0, 150);
  text("floor to your apartment.Each new block has ", 0, 180);
  text("a timer, starting from 33 seconds, getting  ", 0, 210);
  text("shorter each time. When the time ", 0, 240);
  text("reaches 0 the game places a block on the screen for you.", 0, 270);
  text("Make 30 apartment floors (fill 30 rows) ", 0, 300);
  text("and you win a life time of debt! Fill up ", 0, 330);
  text("the grid before that and loose the game.", 0, 360);
  text("On the bright side, you won’t be broke!", 0, 390);
  text("Use the arrow keys to move your piece around the grid.", 0, 420);
  text("Use the space bar to place your shape on the grid", 0, 450);
  text("right click to restart", 0, 480);
  
  //button play
  textSize(30);
  text("play", 430, 740);
  if (screen == 2 && mouseX >= 400 && mouseX<= 400 + 150 && mouseY >= 700 && mouseY <= 700 + 50){
    stroke(0, 0, 0, 0);
    fill(249, 238, 192, 100);
  }
  else {
    stroke(249, 238, 192, 100);
    fill(0,0,0,0);
  }
  rect(400, 700, 150, 50);
}
//screen 3
void Theme(){
  //background
  background(152, 175, 214);
  rect(25, 25, 100, 50);
  fill(250);
  text("Back", 30, 50);
 
  //TEXT
  //Title
  fill(250);
  textFont(Control);
  textSize(50);
  text("Theme", 225, 100);
  
  //THEME CHANGE
  rect(25, 150, 550, 25);
  strokeWeight(1);
  stroke(0);
  fill(0);
  //slider ball
  ellipse(ballX, ballY, 25, 25);
  line(138, 150, 138, 175);
  line(275, 150, 275, 175);
  line(413, 150, 413, 175);
  
  if(ballX >= 37 && ballX < 138){
    theme = 1;
  }
  else if (ballX >= 138 && ballX < 275){
    theme = 2;
  }
  else if (ballX >= 275 && ballX < 413){
    theme = 3;
  }
  else if (ballX >= 413){
    theme = 4;
  }
  fill(250);
  rect(25, 225, 550, 500);
  
  fill(0);
  textSize(20);
  text("1", 86, 135);
  text("2", 200, 135);
  text("3", 330, 135);
  text("4", 488, 135);
  //SAMPLAR
  //Background
  
  tint(160);
  switch(theme){
    case 1: 
    playBackground.resize(500, 450);
    image(playBackground, 50, 250);
    ColorPiece1 = color(99, 92, 146);
    break;
    
    case 2:
    Theme2.resize(500, 450);
    image(Theme2, 50, 250);
    ColorPiece1 = color(93, 114, 147);
    break;
    
    case 3:
    Theme3.resize(500, 450);
    image(Theme3, 50, 250);
    ColorPiece1 = color(136, 133, 150);
    break;
    
    case 4:
    Theme4.resize(500, 450);
    image(Theme4, 50, 250);
    ColorPiece1 = color(60, 104, 57);
    break;
  }
  //samplar shape
  shapeX=250; shapeY =400;
  strokeWeight(5);
  stroke(250);
  fill(ColorPiece1);
  beginShape();
  vertex(shapeX, shapeY);
  vertex(shapeX + 50, shapeY);
  vertex(shapeX + 50, shapeY + 50);
  vertex(shapeX + 100, shapeY + 50);
  vertex(shapeX + 100, shapeY + 100);
  vertex(shapeX, shapeY + 100);
  vertex(shapeX, shapeY);
  endShape(CLOSE);
  
 
  //reset variabes for playing screen
  strokeWeight (1);
  playBackground.resize(900, 800);
  Theme2.resize(900, 800);
  Theme3.resize(700, 800);
  Theme4.resize(900, 800);
}

//screen 4
void Settings(){
  //background
  background(30, 53, 91);
}

//screen 5
void Play(){
  int xIndexStart = (shapeX - 150)/30;
      int yIndexStart = (shapeY - 100)/30;
//BACKGROUND/beginning variables
  tint(160);
  switch(theme){
    case 1: 
    image(playBackground, 0, 0);
    ColorPiece1 = color(99, 92, 146);
    PreviewPiece = color(99, 92, 146, 150);
    ColorPiece2 = color(136, 215, 216);
    break;
    
    case 2:
    image(Theme2, -300, 0);
    ColorPiece1 = color(93, 114, 147);
    PreviewPiece = color(93, 114, 147, 150);
    ColorPiece2 = color(136, 215, 216);
    break;
    
    case 3:
    image(Theme3, -100, 0);
    ColorPiece1 = color(136, 133, 150);
    PreviewPiece = color(136, 133, 150, 150);
    ColorPiece2 = color(136, 215, 216);
    break;
    
    case 4:
    image(Theme4, -150, 0);
    ColorPiece1 = color(60, 104, 57);
    PreviewPiece = color(60, 104, 57, 150);
    ColorPiece2 = color(136, 215, 216);
    break;
  }
  //reset grid variables to draw again later
  gridWidth = 0;
  gridHeight = 0;
  gridX = 150;
  gridY = 100;

  // draw the grid
  for (int gridHeight = 0; gridHeight < 20; gridY += gridUnit ){
    //create the first row on the grid
    for (int gridWidth = 0; gridWidth < 10; gridX +=gridUnit ){
      stroke(100);
      fill(0,0,0);
      rect(gridX, gridY, gridUnit, gridUnit);
      gridWidth ++;
    }
    //create the same row from above 20 more times, lower each time
    gridX = 150;
    gridWidth = 0;
    gridHeight ++;
  }
  
  fill(250, 250, 250);
  textSize(30);
  text("Goal", 50, 550);
  text(levelGoal, 50, 600);
  
  text("Time", 475, 150);
  text(time, 475, 200);
  
//preview
  
  
  switch (preview){
    case 1:
    fill(ColorPiece1, 150);
    rect(shapeX, shapeY, gridUnit, gridUnit);
    rect(shapeX, shapeY + gridUnit, gridUnit, gridUnit);
    rect(shapeX + gridUnit, shapeY + gridUnit, gridUnit, gridUnit);
    shape = "L";
    break;
    
    case 2:
    fill(ColorPiece2, 100);
    rect(shapeX, shapeY, gridUnit, gridUnit);
    rect(shapeX, shapeY + gridUnit, gridUnit, gridUnit);
    rect(shapeX + gridUnit, shapeY + gridUnit, gridUnit, gridUnit);
    rect(shapeX + gridUnit, shapeY, gridUnit, gridUnit);
    shape = "square";
    break;
  }
  
  if(keyPressed && key == ' '){
      // calculate x and y start indicies from shapeX and shapeY
      
    if(shape == "L"){
      // if all parts of the shape are false, draw it
      if (grid[xIndexStart][yIndexStart] == false//top left of shape
      && grid[xIndexStart][yIndexStart + 1] == false//bottom left of shape
      && grid[xIndexStart + 1][yIndexStart + 1] == false){//bottom right of shape
        
        TetrisPiece tetrisPiece = new TetrisPiece(ColorPiece1, shapeX, shapeY); 
        grid = tetrisPiece.fillGrid(grid, shape); //make the units where the tetris piece was placed = to true
        time = 10-Zeroes;//reset the timer
      }
    }
    else if(shape == "square"){
      if (grid[xIndexStart][yIndexStart] == false//top left of shape
      && grid[xIndexStart][yIndexStart + 1] == false//bottom left of shape
      && grid[xIndexStart + 1][yIndexStart + 1] == false
      && grid[xIndexStart +1][yIndexStart] == false){//bottom right of shape
        
        TetrisPiece tetrisPiece = new TetrisPiece(ColorPiece1, shapeX, shapeY); 
        grid = tetrisPiece.fillGrid(grid, shape); //make the units where the tetris piece was placed = to true
        time = 10-Zeroes;//reset the timer
      }
    }
      
      //check to see if a row is filled, if it is clear it
      for (int i = 0; i < collisionGridRows; i++) {
        int rowCount = 0;
        for (int j = 0; j < collisionGridCols; j++) {
          if(grid[j][i] == true){
            ++rowCount;
          }
        }
        if(rowCount == collisionGridCols){
          clearRow(i);
          levelGoal --;
        }
      }
      
      preview = (int)random(1, 3);
  }
  
  
  // draw placed tetris pieces
  //everytime a shape is added to the tetrisPiece list, it will draw it
  for (int i = 0; i < collisionGridRows; i++) {
      for (int j = 0; j < collisionGridCols; j++) {
        if(grid[j][i] == true){
          fill(ColorPiece1);
          rect((j*gridUnit)+150, (i*gridUnit)+100, gridUnit, gridUnit);
        }
      }
  }
 
  //draw the preview shape
  //moves shape using arrow keys
  
  if (keyPressed) {
    
    //moves the shape right 
    if (keyCode == RIGHT && shapeX+60 < 450){
      shapeX += gridUnit;
    }
    
    //moves the shape left
    else if (keyCode == LEFT && shapeX > 150){
      shapeX -= gridUnit;
    }
    
    //moves the shape down
    else if(keyCode == DOWN && shapeY+60 < 700){
      shapeY += gridUnit;
    }
    
    //moves the shape up
    else if(keyCode == UP && shapeY > 100){
      shapeY -= gridUnit;
    }
 
}
  
  
  
  //if the timer is at zero reset the timer to a second shorter than the original time
  if (time <= 0){
    //the varible for the amount of times the timer resets increases
    Zeroes ++;
    time = 10 - Zeroes;
    if(shape == "L"){
      // if all parts of the shape are false, draw it
      if (grid[xIndexStart][yIndexStart] == false//top left of shape
      && grid[xIndexStart][yIndexStart + 1] == false//bottom left of shape
      && grid[xIndexStart + 1][yIndexStart + 1] == false){//bottom right of shape
        
        TetrisPiece tetrisPiece = new TetrisPiece(ColorPiece1, shapeX, shapeY); 
        grid = tetrisPiece.fillGrid(grid, shape); //make the units where the tetris piece was placed = to true
        time = 10 - Zeroes;//reset the timer
      }
    }
    else if(shape == "square"){
      if (grid[xIndexStart][yIndexStart] == false//top left of shape
      && grid[xIndexStart][yIndexStart + 1] == false//bottom left of shape
      && grid[xIndexStart + 1][yIndexStart + 1] == false
      && grid[xIndexStart +1][yIndexStart] == false){//bottom right of shape
        
        TetrisPiece tetrisPiece = new TetrisPiece(ColorPiece2, shapeX, shapeY); 
        grid = tetrisPiece.fillGrid(grid, shape); //make the units where the tetris piece was placed = to true
        time = 10 - Zeroes;//reset the timer
      }
    }
    //place a shape at the current location of the preview shape (if it isn't overlapping a already placed shape)
  }
  else{
    switch (level){
      case 1:
      time -= 0.05;
      break;
      
      case 2:
      time -= 0.04;
      break;
      
      case 3:
      time -= 0.0325;
      break;
    }
    
  }
  //if the time reset more than 9 times, the player loses (shows losing screen)
  if(Zeroes >= 9){
    screen = 6;
  }
  
  if(mousePressed){
    if(mouseButton == RIGHT){
      reset = 1; 
    }
  }
  
  if(reset == 1){
    Zeroes = 0;
    time = 10;
    grid = resetGrid(grid);
    shapeX = 150;
    shapeY= 100;
    reset = 0;
    screen = 1;
  }

  if(levelGoal == 0){
    screen = 7;
  }
}

//screen 6
void Lose(){
  fill(250);
  background(31, 39, 78);
  text("Game Over", 225, 300);
}

//screen 7
void Win(){
  background(31, 39, 78);
  fill(250);
  rect(50, 50, 100, 50);
  text("Win", 225, 300);
  fill(0);
  text("Again", 50, 75);
  
  
}

void clearRow(int row){
  for(int i = 0; i < collisionGridCols; ++i){
    grid[i][row] = false;
  }
}
