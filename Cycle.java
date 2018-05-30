public class Cycle {
    
    private int x;
    private int y;
    private String color;

    public Cycle(String _color, int _x, int _y) {
	x = _x;
	y = _x;
	color = _color;
    }
    
    public void display() {
	//imports sprite of cycle with respective color
    }

    public void update() {
	// animate
    }

    public void boost() {
	// increases speed then reverts back to original speed after a small amount of time
    }

    public void crash() {
	// boolean to check if something is in the same spot
	// check lives
	// game resets or game quits
    }

    
}
