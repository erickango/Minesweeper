

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined
private final static int numBombs = 100;
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
    fill(255);
    background(0);
}
public void displayWinningMessage()
{
    //your code here
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
        if(keyPressed) marked = !marked;
        else if(bombs.contains(this))  displayLosingMessage();
        else if(countBombs(r, c) > 0) label += countBombs(r, c);
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
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if((r >= 0 && r < NUM_ROWS) && (c >= 0 && c < NUM_COLS))       return true;
        else return false;
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

//
//        }
 //       else{
 //           if()



//        }
        return numBombs;
    }
}



