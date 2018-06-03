import java.util.*;
import javax.swing.*;

Arena a;
Cycle c;
Cycle c2;
homeScreen h;



void setup() {
  size(700,500);
  h=new homeScreen(700,500);
  c = new Cycle(650, 250, 0,700,500,a);
  c2 = new Cycle(50, 250, 1,700,500,a);
  ArrayList<Cycle> cyc = new ArrayList();
  cyc.add(c);
  cyc.add(c2);
  a = new Arena(700,500,cyc);
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
  h.mousePressed();
  if(h.isStart()){
   background(0, 0, 54);
   noStroke();
   a.display();
   if (c.GameOver == false&&c2.GameOver==false) {
    a.update();
    //if((a.isAvail((int)c.getNextX(),(int)c.getNextY()))){
    fill(0,0,255);
    //c.update();
    c.display();
    keyPressed();
    //}
    //if((a.isAvail((int)c2.getNextX(),(int)c2.getNextY()))){
    fill(255,0,0);
    c2.update();
    c2.display();
    keyPressed();
    //}
  } else {
    fill(255,0,0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Game Over", 350, 250);
    if(c.GameOver==false){
      fill(255,0,0);
      textSize(30);
      textAlign(CENTER, CENTER);
      text("Player 1 Wins", 350, 300);
    } 
    else{
      fill(255,0,0);
      textSize(30);
      textAlign(CENTER, CENTER);
      text("Player 2 Wins", 350, 300);
    }
  }
 }
}

class Cycle {
  PVector location;
  PVector velocity;
  boolean GameOver = false;
  Arena ar;
  int maxX;
  int maxY;
  int num;
  int OGlives;
  int lives;
  Cycle(int _x, int _y, int n,int mX, int mY,Arena a){
    num = n;
    location = new PVector(_x, _y);
    maxX=mX;
    maxY=mY;
    ar=a;
    OGlives = 0;
    lives = 0;
    if (n == 0) {
      velocity = new PVector(-3, 0);
    } else {
      velocity = new PVector(3, 0); 
    }
    rect(location.x, location.y, 20, 10);
  }
  void addArena(Arena a) {
    ar = a;
  }
  void update() {
    //OGlives = lives;
    if (lives >= 0) {
      if (velocity.x > 0) {
        if(location.x < maxX - 41 /*&& ar.arena[(int)getNextX() + 21][(int)location.y]>-.5*/&&(ar.arena[(int)getNextX() + 21][(int)location.y]==0)){
          location = location.add(velocity);
        } else {
          lives --;
          GameOver=true;
      }
    }
    else if (velocity.x < 0) {
      if (location.x >= 21 /*&& ar.arena[(int)getNextX() - 12][(int)location.y]>-.5*/&& ar.arena[(int)getNextX() - 12][(int)location.y]==0){
        location = location.add(velocity);
      } else {
        lives --; 
        GameOver = true;
      }
    } else if (velocity.y > 0) {
      if(location.y < maxY - 41 /*&& ar.arena[(int)location.x][(int)getNextY() + 21]>-.5*/&&ar.arena[(int)location.x][(int)getNextY()+21]==0) {
        location = location.add(velocity);
      } else {
        lives --;
        GameOver = true;
      }
    } else if (velocity.y < 0) {
        if(location.y >= 21 /*&& ar.arena[(int)location.x][(int)getNextY() - 12]>-.5*/&&ar.arena[(int)location.x][(int)getNextY() - 12]==0) { 
          location = location.add(velocity);
        } else {
           lives --;
           GameOver = true;
        }
      }
    }
  }
  
  // accessors
  float getX(){
    return location.x; 
  }
  float getY(){
    return location.y; 
  }
  float getNextX(){
    float temp = location.x + velocity.x;
    return temp; 
  }
  float getNextY(){
    float temp = location.y + velocity.y;
    return temp; 
  }
  // movement
  void up() {
    velocity.y = -3;
    velocity.x = 0;
  }
  void down() {
    velocity.y = 3;
    velocity.x = 0;
  }
  void left() {
    velocity.y = 0;
    velocity.x = -3;
  }
 void right() {
    velocity.y = 0;
    velocity.x = 3;
  }
  // directional change
  void display() {
    if (velocity.x > 0 || velocity.x < 0) {
      rect(location.x, location.y, 20, 10);
    } else if (velocity.y > 0 || velocity.y < 0 ) {
      rect(location.x, location.y, 10, 20); 
    }
  }
   
}

class Arena {
   
  float[][] arena;
  int[] obs;
  ArrayList <Cycle> cycles;
  Arena(int x,int y,ArrayList<Cycle> cycs) {
    cycles = cycs;
    obs=new int[2];
    arena = new float[x][y];
  }
  void createObstacles(){
      obs[0]=(int)(random(20,(arena.length-60)));
      obs[1]=(int)(random(20,(arena[0].length-60)));
  }
  void update() {

    // putting values in array for trails
    for(Cycle cycle: cycles){
      if (cycle.num == 0) {
        if(arena[(int)cycle.getX()][(int)cycle.getY()]==0){
          arena[(int)cycle.getX()][(int)cycle.getY()]=1;
        }
      } else {
        if(arena[(int)cycle.getX()][(int)cycle.getY()]==0){
          arena[(int)cycle.getX()][(int)cycle.getY()]=2;
        }
      }
      if(arena[obs[0]][obs[1]]<=-1||obs[0]==0||obs[1]==0){
        createObstacles();
      }
      else{
        arena[obs[0]][obs[1]]-=.1;
        if(arena[obs[0]][obs[1]]<=-1){
            arena[obs[0]][obs[1]]=-1;
        }
        //System.out.println(arena[obst[0]][obst[1]]);
      }
    }
    // trail coloring
    for (int x = 0; x < arena.length; x ++) {
      for (int y = 0; y < arena[x].length; y ++) {
        if (arena[x][y] == 1) {
          fill(0, 0, 255);
          rect((float)x, (float)y, 10, 10);
        } else if (arena[x][y] == 2) {
          fill(255, 0, 0); 
          rect((float)x, (float)y, 10, 10);
        }
        else if(arena[x][y]<0){
            float val=0-arena[x][y];
            fill(255*val,255*val,255*val);
            rect((float)x, (float)y, 10, 10);
        }
     }
   }
  }
   void display(){
     for(int x=0;x<arena.length;x++){
       fill(0);
       rect(x,0,20,20);
       rect(x,arena[0].length-20,20,20);
     }
     for(int y=0;y<arena[0].length;y++){
       fill(0);
       rect(0,y,20,20);
       rect(arena.length-20,y,20,20);
     }
   }
     /*
  boolean isAvail(int x,int y){
    if(x >= arena.length || x < 0 || y >= arena[x].length || y < 0 || arena[x][y] == 1) {
      return false;
    }
      return true;
  }
  */
}
class homeScreen{
  boolean start;
  PImage img;
  float x;
  float y;
  homeScreen(float _x,float _y){
     start=false;
     x=_x;
     y=_y;
     background(0);
     img = loadImage("logo.jpg");
     image(img,0,0,700,300);
     rect(x/2-50,y/2,100,50);
     fill(0);
     textSize(24);
     text("START",x/2-40,y/2+30);
  }
  void start(){
    start=!start;
  }
  boolean isStart(){
    return start;
  }
  void mousePressed(){
    if(start==false&&mouseX>x/2-50&&mouseX<x/2+50&&mouseY>y/2&&mouseY<y/2+50&&mouseButton==LEFT){
      start();
    }
  }
  void update(){
    background(0);
    fill(255);
    rect(x/2-50,y/2-10,100,50);
  }
}
