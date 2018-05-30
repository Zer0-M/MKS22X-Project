import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TRON extends PApplet {

Arena a;
Cycle c;
public void setup(){
  a=new Arena();
  
  background(0, 0, 54);
  c=new Cycle(650,250);
}
public void keyPressed(){
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
public void draw(){
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
  public void update(){
     location=location.add(velocity);
  }
  public void up(){
     velocity.y=-2;
     velocity.x=0;
  }
  public void down(){
     velocity.y=2;
     velocity.x=0;
  }
  public void left(){
     velocity.y=0;
     velocity.x=-2;
  }
 public void right(){
     velocity.y=0;
     velocity.x=2;
  }
  public void display(){
       rect(location.x,location.y,20,10);
  }
   
}
class Arena{

  
}
  public void settings() {  size(700,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TRON" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
