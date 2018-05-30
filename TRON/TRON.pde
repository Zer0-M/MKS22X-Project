Arena a;
Cycle c;
void setup(){
  a=new Arena();
  size(700,500);
  background(0, 0, 54);
  c=new Cycle(650,250);
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
   background(0, 0, 54);
   c.update();
   c.display();
   
}
class Cycle{
  PVector location;
  PVector velocity;
  int dir;
  Cycle(int _x,int _y){
     location=new PVector(_x,_y);
     velocity=new PVector(-2,0);
     dir=1;
     rect(location.x,location.y,20,10);
  }
  void update(){
     location=location.add(velocity);
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

  
}