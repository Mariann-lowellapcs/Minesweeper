import de.bezier.guido.*;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_COLS = 35;
public final static int NUM_ROWS = 35;
public int nBombs = 100;
public int realBombs = 0;
public boolean gameOver = false;

void setup ()
{
    size(507, 505);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int rows = 0; rows < NUM_ROWS; rows ++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[rows][c] = new MSButton(rows,c);
        }
    }

    bombs = new ArrayList<MSButton>();
    
    
    
    
    setBombs();
}
public void setBombs()
{
    for(int i = 0; i < nBombs; i++)
    {
        int bRow = (int)(Math.random()*NUM_ROWS);
        int bCol = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[bRow][bCol]))
        {
            bombs.add(buttons[bRow][bCol]); 
            //realBombs += 1;
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true){
        displayWinningMessage();
    }

}
public boolean isWon()
{
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(!buttons[r][c].isClicked() == true && !bombs.contains(buttons[r][c]))
        {
        return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
   for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(!buttons[r][c].isClicked() && bombs.contains(buttons[r][c]))
            {
                buttons[r][c].marked = false;
                buttons[r][c].clicked = true;
                buttons[0][9].setLabel("Y");
                buttons[0][10].setLabel("O");
                buttons[0][11].setLabel("U");
                buttons[0][12].setLabel("L");
                buttons[0][13].setLabel("O");
                buttons[0][14].setLabel("S");
                buttons[0][15].setLabel("T");
                buttons[0][16].setLabel("!");
                buttons[12][9].setLabel("Y");
                buttons[12][10].setLabel("O");
                buttons[12][11].setLabel("U");
                buttons[12][12].setLabel("L");
                buttons[12][13].setLabel("O");
                buttons[12][14].setLabel("S");
                buttons[12][15].setLabel("T");
                buttons[12][16].setLabel("!");
                buttons[20][9].setLabel("Y");
                buttons[20][10].setLabel("O");
                buttons[20][11].setLabel("U");
                buttons[20][12].setLabel("L");
                buttons[20][13].setLabel("O");
                buttons[20][14].setLabel("S");
                buttons[20][15].setLabel("T");
                buttons[20][16].setLabel("!");
            }
        }
    }
}
public void displayWinningMessage()
{
    
    buttons[0][0].setLabel("C");
    buttons[0][1].setLabel("O");
    buttons[0][2].setLabel("N");
    buttons[0][3].setLabel("G");
    buttons[0][4].setLabel("R");
    buttons[0][5].setLabel("A");
    buttons[0][6].setLabel("T");
    buttons[0][7].setLabel("S");
    buttons[0][8].setLabel("!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 800/NUM_COLS;
         height = 800/NUM_ROWS;
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
        if(keyPressed == true || mousePressed && (mouseButton == RIGHT))
        {
            if(marked == false)
            {
                marked = true;
            }
            else if (marked == true)
            {
                clicked = false;
                marked =  false;     
            }
        }
        else if (bombs.contains(this))
        {
            displayLosingMessage(); 
        }
        else if (countBombs(r,c) > 0) 
        {
            setLabel("" + countBombs(r,c));
        }
        else
        {
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
            {
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
            {
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
            {
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
            {
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
            {
                buttons[r+1][c+1].mousePressed();
            }
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
            {
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
            {
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
            {
                buttons[r-1][c+1].mousePressed();
            }
            
        }
    }
        //your code here


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
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row+1, col) == true && bombs.contains(buttons[row+1][col]))
        {
            numBombs ++;
        }
        if(isValid(row+1, col+1) == true && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs ++;
        }
        if(isValid(row, col+1) == true && bombs.contains(buttons[row][col+1]))
        {
            numBombs ++;
        }
        if(isValid(row-1, col) == true && bombs.contains(buttons[row-1][col]))
        {
            numBombs ++;
        }
        if(isValid(row, col-1) == true && bombs.contains(buttons[row][col-1]))
        {
            numBombs ++;
        }
        if(isValid(row-1, col-1) == true && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs ++;
        }
        if(isValid(row-1, col+1) == true && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs ++;
        }
        if(isValid(row+1, col-1) == true && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs ++;
        }
        return numBombs;
    }
}
