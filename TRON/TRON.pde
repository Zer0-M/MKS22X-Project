Arena a;
Cycle c;
Cycle c2;

void setup(){
  size(700,500);
  background(0, 0, 54);
  c = new Cycle(650, 250, 0,700,500,a);
  c2 = new Cycle(50, 250, 1,700,500,a);
  ArrayList<Cycle> cyc = new ArrayList();
  cyc.add(c);
  cyc.add(c2);
  a = new Arena(1400,1000,cyc);
  c.addArena(a);
  c2.addArena(a);
}
void keyPressed() {
    if(keyCode == UP && c.velocity.y == 0){
       c.up();
    }
    if(keyCode == DOWN && c.velocity.y == 0){
       c.down();
    }
    if(keyCode == LEFT && c.velocity.x == 0){
       c.left();
    }
    if(keyCode == RIGHT && c.velocity.x == 0){
       c.right();
    }
    if(keyCode == 'W' && c2.velocity.y == 0){
       c2.up();
    }
    if(keyCode == 'S' && c2.velocity.y == 0){
       c2.down();
    }
    if(keyCode == 'A' && c2.velocity.x == 0){
       c2.left();
    }
    if(keyCode == 'D' && c2.velocity.x == 0){
       c2.right();
    }
}

void draw(){
   background(0, 0, 54);
   noStroke();
   a.update();
   //if((a.isAvail((int)c.getNextX(),(int)c.getNextY()))){
      fill(0,0,255);
      c.update();
      c.display();
      keyPressed();
   //}
   //if((a.isAvail((int)c2.getNextX(),(int)c2.getNextY()))){
      fill(255,0,0);
      c2.update();
      c2.display();
      keyPressed();
   //}
}

class Cycle {
  PVector location;
  PVector velocity;
  Arena ar;
  int maxX;
  int maxY;
  int num;
  Cycle(int _x, int _y, int n,int mX, int mY,Arena a){
     num = n;
     location = new PVector(_x, _y);
     maxX=mX;
     maxY=mY;
     ar=a;
     if (n == 0) {
       velocity = new PVector(-2, 0);
     } else {
       velocity = new PVector(2, 0); 
     }
     rect(location.x, location.y, 20, 10);
  }
  void addArena(Arena a){
    ar=a;
  }
  void update() {
    if (velocity.x > 0) {
     if(location.x<maxX-21&&ar.arena[(int)getNextX()+20][(int)location.y]==0){
     location = location.add(velocity);
     }
    }
    else if(velocity.x < 0){
      if(location.x>=21&&ar.arena[(int)getNextX()-12][(int)location.y]==0){
       location = location.add(velocity);
      }
    }
    else if (velocity.y > 0) {
     if(location.y<maxY-41&&ar.arena[(int)location.x][(int)getNextY()+20]==0){
     location = location.add(velocity);
     }
    }
    else if(velocity.y < 0){
      if(location.y>=41&&ar.arena[(int)location.x][(int)getNextY()-12]==0){
       location = location.add(velocity);
      }
    }


  }
  float getX(){
     return location.x; 
  }
  float getY(){
     return location.y; 
  }
  float getNextX(){
     float temp=location.x+velocity.x;
     return temp; 
  }
  float getNextY(){
     float temp=location.y+velocity.y;
     return temp; 
  }

  void up() {
     velocity.y = -2;
     velocity.x = 0;
  }
  void down() {
     velocity.y = 2;
     velocity.x = 0;
  }
  void left() {
     velocity.y = 0;
     velocity.x = -2;
  }
 void right() {
     velocity.y = 0;
     velocity.x = 2;
  }
  void display() {
    if (velocity.x > 0 || velocity.x < 0) {
       rect(location.x, location.y, 20, 10);
    } else if (velocity.y > 0 || velocity.y < 0 ) {
       rect(location.x, location.y, 10, 20); 
    }
  }
   
}

class Arena{
   int[][] arena;
   ArrayList<Cycle> cycles;
   Arena(int x,int y,ArrayList<Cycle> cycs){
      cycles=cycs;
      arena=new int[x][y];
   }
   void update(){
     for(Cycle cycle: cycles){
       if (cycle.num == 0) {
         arena[(int)cycle.getX()][(int)cycle.getY()]=1;
       } else {
         arena[(int)cycle.getX()][(int)cycle.getY()]=2;
       }
     }
     for (int x = 0; x < arena.length; x ++) {
        for (int y = 0; y < arena[x].length; y ++) {
           if (arena[x][y] == 1) {
              fill(0, 0, 255);
              rect((float)x, (float)y, 10, 10);
           } else {
              fill(255, 0, 0); 
           }
        }
     }
   }
   /*
   boolean isAvail(int x,int y){
     if(x>=arena.length||x<0||y>=arena[x].length||y<0||arena[x][y]==1){
       return false;
     }
     return true;
   }
   */
}