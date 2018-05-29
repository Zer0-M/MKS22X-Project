Arena a;
void setup(){
  a.setup();
}
void draw(){
  a.draw(); 
}
class Cycle{
  int x;
  int y;
  int velocity;
  int dir;
  Cycle(int _x,int _y){
     x=_x;
     y=_y;
     velocity=2;
     dir=1;
     rect(x,y,25,25);
  }
  void update(){
     if(dir==0){
       y+=velocity;
     }
     if(dir==1){
       x-=velocity;
     }
     if(dir==2){
       y-=velocity;
     }
     else{
       x+=velocity;
     }
  }
  void display(){
       rect(x,y,25,25);
  }
   
}
class Arena{
  Cycle c;
  void setup(){
     size(700,500);
     background(0, 0, 54);
     c=new Cycle(650,250);
  }
  void draw(){
     background(0, 0, 54);
     c.display();
     c.update();
  }
  
}