

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public boolean lost= false;


private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined
private final static int numBombs = 50;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i < NUM_ROWS; i++){
        for(int s = 0; s < NUM_COLS; s++){
            buttons[i][s] = new MSButton(i, s);
        }
    }
    for(int i = 0; i < numBombs; i++)
        setBombs();
}
public void setBombs()
{
    int col = (int)(Math.random() * 20);
    int row = (int)(Math.random() * 20);
    if(!bombs.contains(buttons[row][col])){
        bombs.add(new MSButton(row, col));
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    background(255);
    textAlign(CENTER);
    text("You Lost", 200, 200);
}
public void displayWinningMessage()
{
    //your code here
    background(255);
    textAlign(CENTER);
    text("You WON!", 200, 200);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;

        //your code here
    if(mousePressed && mouseButton == RIGHT){
         marked = !marked;
         clicked = !clicked;
     }
    else if(bombs.contains(this))  {
         //   displayLosingMessage();
            lost = true;
      }
    else if(countBombs(r, c) > 0){
        setLabel("" + countBombs(r, c)+ "");
    }

    else{




          if(isValid(r,c-1) && (buttons[r][c-1].isClicked() == false))

            buttons[r][c-1].mousePressed();

        
          if(isValid(r, c+1) && (buttons[r][c+1].isClicked() == false))
            buttons[r][c+1].mousePressed();
          if(isValid(r+1, c) && (buttons[r+1][c].isClicked() == false))
            buttons[r+1][c].mousePressed();
          if(isValid(r-1, c) && (buttons[r-1][c].isClicked() == false))
            buttons[r-1][c].mousePressed();
    }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
     //   if(lost == true) displayLosingMessage();
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int row, int col)
    {

        if((row < 0 || col < 0) || (row > NUM_ROWS-1) || col > NUM_COLS-1) return false;
        else return true;

    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
  //      if((row - 1 >= 0 && row + 1 < 20) && (col >= 0 && col < 20)) {
            if(isValid(row, col - 1) && bombs.contains(buttons[row][col-1])) numBombs += 1;
            if(isValid(row, col + 1) && bombs.contains(buttons[row][col+1])) numBombs += 1;
            if(isValid(row+1, col) && bombs.contains(buttons[row+1][col])) numBombs += 1;
            if(isValid(row+1, col - 1) && bombs.contains(buttons[row+1][col-1])) numBombs += 1;
            if(isValid(row+1, col + 1) && bombs.contains(buttons[row+1][col+1])) numBombs += 1;
            if(isValid(row-1, col) && bombs.contains(buttons[row-1][col])) numBombs += 1;
            if(isValid(row-1, col - 1) && bombs.contains(buttons[row-1][col-1])) numBombs += 1;
            if(isValid(row-1, col + 1) && bombs.contains(buttons[row-1][col+1])) numBombs += 1;
            System.out.println(bombs.contains(buttons[r][c]));
        return numBombs;
    }
}



