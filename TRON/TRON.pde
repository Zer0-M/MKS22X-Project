Arena a;
Cycle c;
void setup(){
  size(700,500);
  background(0, 0, 54);
  c=new Cycle(650,250);
  ArrayList<Cycle> cyc=new ArrayList();
  cyc.add(c);
  a=new Arena(700,500,cyc);
}
void keyPressed(){
    if(keyCode==UP){
       c.up();
    }
    if(keyCode==DOWN){
       c.down();
    }
    if(keyCode==LEFT){
       c.left();
    }
    if(keyCode==RIGHT){
       c.right();
    }
}
void draw(){
   noStroke();
   a.update();
   if((a.isAvail((int)c.getNextX(),(int)c.getNextY()))){
      c.update();
      c.display();
      keyPressed();
   }
   c.display();
   
}
class Cycle{
  PVector location;
  PVector velocity;
  Cycle(int _x,int _y){
     location=new PVector(_x,_y);
     velocity=new PVector(-2,0);
     rect(location.x,location.y,20,10);
  }
  void update(){
     location=location.add(velocity);
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
  void up(){
     velocity.y=-2;
     velocity.x=0;
  }
  void down(){
     velocity.y=2;
     velocity.x=0;
  }
  void left(){
     velocity.y=0;
     velocity.x=-2;
  }
 void right(){
     velocity.y=0;
     velocity.x=2;
  }
  void display(){
       rect(location.x,location.y,20,10);
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
         arena[(int)cycle.getX()][(int)cycle.getY()]=1;
     }
   }
   boolean isAvail(int x,int y){
     if(x>=arena.length||x<0||y>=arena[x].length||y<0||arena[x][y]==1){
       return false;
     }
     return true;
   }
  
}