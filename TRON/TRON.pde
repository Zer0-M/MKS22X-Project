import java.util.*;
import javax.swing.*;

Arena a;
Cycle c; // 1 player
Cycle c2; // 2 player
homeScreen h;
boolean obson;
PImage img;
PImage win1;
PImage win2;
PImage Draw;
PImage rest;

PGraphics pg;
InstructionScreen i;

void setup() {
  img=loadImage("Over.png");
  win1=loadImage("1PWin.png");
  win2=loadImage("2PWin.png");
  Draw=loadImage("draw.png");
  rest=loadImage("restart.png");
  size(750,550);
  obson=false;
  pg = createGraphics(760, 560);
  h=new homeScreen(760, 560);
  c = new Cycle(690, 280, 0, 750, 550, a);
  c2 = new ComCycle(50, 280, 1, 750, 550, c, a);
  ArrayList<Cycle> cyc = new ArrayList();
  cyc.add(c);
  cyc.add(c2);
  a = new Arena(750, 550, cyc,h.obson());
  c.addArena(a);
  c2.addArena(a);
  i=new InstructionScreen(760,560,h.isCom());
}

void keyPressed() {
  // controls
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
  // speed boost
  if(keyCode == CONTROL) {
    c.boostTimer = 900;
    if (c.boostTimer > 0) {
      if (c.velocity.x == -2) {
        c.velocity.x -= 2;
      }
      if (c.velocity.x == 2) {
        c.velocity.x += 2;
      }
      if (c.velocity.y == -2) {
        c.velocity.y -= 2;
      }
      if (c.velocity.y == 2) {
        c.velocity.y += 2;
      }
    }
  }
  if(!h.isCom()){
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
  // speed boost 
  if(keyCode == SHIFT) {
    c2.boostTimer = 900;
    if (c2.boostTimer > 0) {
      if (c2.velocity.x == -2) {
        c2.velocity.x -= 2;
      }
      if (c2.velocity.x == 2) {
        c2.velocity.x += 2;
      }
      if (c2.velocity.y == -2) {
        c2.velocity.y -= 2;
      }
      if (c2.velocity.y == 2) {
        c2.velocity.y += 2;
      }
    }
  }
  }
}
  void mousePressed(){
    //mouse press for restart button
    int x=a.arena.length;
    int y=a.arena[0].length;
    if(mousePressed&&(c.GameOver==true||c2.GameOver==true)&&mouseX>x/2-55&&mouseX<x/2+45&&mouseY>y/2+70&&mouseY<y/2+100&&mouseButton==LEFT){
      c = new Cycle(690, 280, 0,750,550,a);
      c2 = new ComCycle(50, 280, 1,750,550,c,a);
      restart();
      h.start();
      h=new homeScreen(760,560);
      i=new InstructionScreen(760,560,h.isCom());
      mousePressed=false;
    }
  }
void restart() {
  //restarts the game
  keyCode=RIGHT;
  c.location = new PVector(690, 280);
  c.left();
  keyCode='D';
  c2.location = new PVector(50, 280);
  c2.right();
  ArrayList<Cycle> cyc = new ArrayList();
  cyc.add(c);
  cyc.add(c2);
  a = new Arena(750, 550, cyc,h.obson());
  c.addArena(a);
  c2.addArena(a);
}
void draw() { 
  if(h.isStart()) {
    i.isCom(h.isCom());
    i.display();
    i.mouseClicked();
    if(i.isStart()){
    background(0, 0, 54);
    noStroke();
    a.display();
    if (!c.Restart && !c2.Restart) {
     a.update();
    rectMode(CORNER);
    fill(0,0,255);
    c.update();
    c.display();
    keyPressed();
    fill(255,0,0);
    c2.update();
    c2.display();
    keyPressed();
  } else {
    //check if a life is lost
    a.update();
    fill(0,0,255);
    c.display();
    fill(255,0,0);
    c2.display();
    if (c.Restart || c2.Restart ) {
      //gameover and who wins screens
      if (c.lives < 0 || c2.lives < 0) {
        pg.beginDraw();
        pg.background(0,0,0,200);
        pg.image(img,220,250);
        if(c.GameOver &&c2.GameOver){
          pg.image(Draw,310,290,100,30);
        }
        else if(!c.GameOver){
          pg.image(win1,260,290,200,30);
        } 
        else{
          pg.image(win2,260,290,200,30);
        }
        int x=a.arena.length;
         int y=a.arena[0].length;
         pg.noFill();
         pg.stroke(255);
         pg.strokeWeight(7);
         pg.rect(x/2-65,y/2+60,120,45);
         pg.image(rest,x/2-55,y/2+70,100,30);
         mousePressed();
         pg.endDraw();
        image(pg,0,0);
      } else {
        restart();
         c.Restart = false;
         c2.Restart = false;
      }
    }
  }
    }
  } else {
    h.mouseReleased();
    h.update();
    if(!h.isCom()) {
      c2 = new Cycle(50, 280, 1, 750, 550, a);
    } 
    ArrayList<Cycle> cyc = new ArrayList();
    cyc.add(c);
    cyc.add(c2);
    a = new Arena(750, 550, cyc,h.obson());
    c.addArena(a);
    c2.addArena(a);
  }
}

class Cycle {
  PVector location;
  PVector velocity;
  boolean GameOver = false;
  boolean Restart = false;
  Arena ar;
  int maxX;
  int maxY;
  int livesX;
  int livesY;
  int num;
  int lives;
  int boostTimer;
  PImage lc;
  
  Cycle(int _x, int _y, int n,int mX, int mY,Arena a){
    num = n;
    location = new PVector(_x, _y);
    livesX =_x;
    livesY = _y - 200;
    maxX = mX;
    maxY = mY;
    ar = a;
    lives = 3;
    GameOver = false;
    if (n == 0) {
      lc=loadImage("bike1.png");
      velocity = new PVector(-2, 0);
    } else {
      lc=loadImage("bike2.png");
      velocity = new PVector(2, 0);
    }
    rect(location.x, location.y, 20, 10);
  }
  
  void addArena(Arena a) {
    ar = a;
  }
  //check for collisons
  boolean isCollide(int mode) {
    boolean collide=false;
    if(mode == 0) {
      for(int i = 18; i >= 0 && !collide; i -= 2) {
        if(ar.arena[(int)getNextX() + i][(int)location.y] > 0 || ar.arena[(int)getNextX() + i][(int)location.y] <= -1) {
          collide = true;
        }
      }
    } else if (mode == 1) {
      for(int i = 18; i >= 0 && !collide; i -= 2) {
        if(ar.arena[(int)getNextX() - i][(int)location.y] > 0 || ar.arena[(int)getNextX() - i][(int)location.y] <= -1) {
          collide = true;
        }
      }
    } else if (mode == 2) {
      for(int i = 18; i >= 0 && !collide; i -=2) {
        if(ar.arena[(int)location.x][(int)getNextY() + i] > 0 || ar.arena[(int)location.x][(int)getNextY() + i] <= -1) {
          collide = true;
        }
      }
    } else if (mode == 3) {
      for(int i = 18; i >= 0 && !collide; i -= 2) {
        if(ar.arena[(int)location.x][(int)getNextY() - i] > 0 || ar.arena[(int)location.x][(int)getNextY() - i] <= -1) {
          collide = true;
        }
      }
    }
    return collide;
  }
  //decrease lives
  void update() {
    if (lives >= 0) {
      textSize(30);
      text(lives, livesX, livesY);
      if (velocity.x > 0) {
        boolean collide = isCollide(0);
        if(location.x < maxX - 41 && !collide) {
          location = location.add(velocity);
        } else {
          lives --;
          Restart = true;
          if (lives < 0) {
            GameOver = true; 
            Restart = true;
          }
        }
      } else if (velocity.x < 0) {
        boolean collide=isCollide(1);
        if (location.x >= 21 && !collide) {
          location = location.add(velocity);
        } else {
          lives --;
          Restart = true;
          if (lives < 0) {
            GameOver = true; 
            Restart = true;
          }
        }
      } else if (velocity.y > 0) {
        boolean collide=isCollide(2);
        if(location.y < maxY - 41 &&!collide) {
          location = location.add(velocity);
        } else {
          lives --;
          Restart = true;
          if (lives < 0) {
            GameOver = true; 
            Restart = true;
          }        
        }
      } else if (velocity.y < 0) {
        boolean collide=isCollide(3);
        if(location.y >= 21 &&!collide) { 
          location = location.add(velocity);
        } else {
          lives --;
          Restart = true;
          if (lives < 0) {
            GameOver = true; 
            Restart = true;
          }
        }
      }
    }
  boostTimer --;
  }
  
  // accessors
  Arena getArena() {
    return ar;
  }
  PVector getVelocity() {
    return velocity;
  }
  float getX() {
    return location.x; 
  }
  float getY() {
    return location.y; 
  }
  float getNextX() {
    float temp = location.x + velocity.x;
    return temp; 
  }
  float getNextY() {
    float temp = location.y + velocity.y;
    return temp; 
  }
  // movement
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
  // directional change
  void display() {
    if (velocity.x > 0 || velocity.x < 0) {
        pushMatrix();
        translate(location.x,location.y);
        if(velocity.x<0){
          rotate(-PI);
          image(lc,-50,-20,100,400);
        }
        else{
          image(lc,-30,-10,100,400);
        } 
        popMatrix();
    } else if (velocity.y > 0 || velocity.y < 0 ) {
        pushMatrix();
        translate(location.x,location.y);
        if(velocity.y<0){
          rotate(-HALF_PI);
          image(lc,-50,-10,100,400);
        }
        else{
          rotate(HALF_PI);
          image(lc,-30,-20,100,400);
        } 
        popMatrix();
      }
  }
   
}

class Arena {
   
  float[][] arena;
  int[] obs;
  ArrayList <Cycle> cycles;
  int type;
  boolean obstacles;
  
  Arena(int x, int y, ArrayList<Cycle> cycs,boolean useOb) {
    obstacles=useOb;
    cycles = cycs;
    obs = new int[6];
    arena = new float[x][y];
    type=(int)random(4);
  }
  //enables or disables obs
  void useObs(){
    obstacles=!obstacles;
  }
  //this method creates obstacle positions
  void createObstacles() {
      Random rand = new Random();
      removeRow();
      removeCol();
      obs[0] = (int)((int)rand.nextInt((arena.length - 40) /2) * 2);
      obs[1] = (int)((int)rand.nextInt((arena[0].length - 40) /2) * 2);
      obs[2] = (int)((int)rand.nextInt((arena.length - 40) /2) * 2);
      obs[3] = (int)((int)rand.nextInt((arena[0].length - 40) /2) * 2);
      obs[4] = (int)((int)rand.nextInt((arena.length - 40) /2) * 2);
      obs[5] = (int)((int)rand.nextInt((arena[0].length - 40) /2) * 2);
  }
  void removeRow(){
      for (int r = 20; r < 750; r ++) {
        for (int c = 0; c < 10; c ++) {
          if (arena[r][obs[5] + c] < -1) {
            arena[r][obs[5] + c] +=1.5;
          }
        }
      }
  }
  void removeCol(){
      for (int r = 0; r < 10; r ++) {
        for (int c = 20; c < 550 - 20; c ++) {
          if (arena[obs[4] + r][c] < -1) {
            arena[obs[4] + r][c] +=1.5;
          }
        }
      }
  }
  void createCols() {
    // cols
      for (int r = 0; r < 10; r ++) {
        for (int c = 20; c < 550 - 20; c ++) {
          if (arena[obs[4] + r][c] < 1) {
            arena[obs[4] + r][c] -= .005;
          }
        }
      }
  }
  void createRows(){  
      //rows
      for (int r = 20; r < 750; r ++) {
        for (int c = 0; c < 10; c ++) {
          if (arena[r][obs[5] + c] < 1) {
            arena[r][obs[5] + c] -= .005;
          }
        }
      }
  }
  
  void update() {
    // putting values in array for trails
    for(Cycle cycle: cycles) {
      if (cycle.num == 0) {
        if(arena[(int)cycle.getX()][(int)cycle.getY()] == 0){
          arena[(int)cycle.getX()][(int)cycle.getY()] = 1;
        }
      } else {
        if(arena[(int)cycle.getX()][(int)cycle.getY()] == 0){
          arena[(int)cycle.getX()][(int)cycle.getY()] = 2;
        }
      }
    }
    if(obstacles){
    if(arena[20][obs[5]] <= -1||arena[obs[4]][20] <= -1 ||arena[obs[2]][obs[3]] <= -1 ||arena[obs[0]][obs[1]] <= -1 || obs[0] <= 25 || obs[1] <= 25 || obs[0] > arena.length - 41 || obs[1] > arena[0].length - 41) {
      createObstacles();
      type=(int)random(4);
    } else {
      // small obstacles
      if(type==0){
      for(int r = 0; r < 10; r++) {
        for(int c = 0; c < 10; c++) {
          if(arena[obs[0] + r][obs[1] + c] < 1) {
            arena[obs[0] + r][obs[1] + c] -= .008;
          }
        }
      }
      }
      else if(type==1){
      // big obstacles
      for (int r = 0; r < 20; r ++) {
        for (int c = 0; c < 20; c ++) {
          if (arena[obs[2] + r][obs[3] + c] < 1) {
             arena[obs[2] + r][obs[3] + c] -= .008; 
          }
        } 
      }
      }
      else if(type==2){
      createRows();
      } 
      else{
        createCols();
      }
    }
    }
    // trail coloring
    for (int x = 0; x < arena.length; x ++) {
      for (int y = 0; y < arena[x].length; y ++) {
        if (arena[x][y] == 1) {
          rectMode(CORNER);
          fill(0, 0, 255);
          rect((float)x, (float)y, 10, 10);
        } else if (arena[x][y] == 2) {
          rectMode(CORNER);
          fill(255, 0, 0); 
          rect((float)x, (float)y, 10, 10);
        } else if (arena[x][y]<0) {
          int remove=(int)random(10);
          float val=0-arena[x][y];
          rectMode(CORNER);
          fill(0,255*val,0);
          rect((float)x, (float)y, 2, 2);
        }
      }
    }
  }
  
  void display() {
    //border
    rectMode(CORNER);
    for(int x = 0; x < arena.length; x++) {
      fill(0);
      rect(x, 0, 20, 20);
      rect(x, arena[0].length - 20, 20, 20);
    }
     for(int y = 0; y < arena[0].length; y++) {
       fill(0);
       rect(0, y, 20, 20);
       rect(arena.length - 20, y, 20, 20);
     }
  }
  
}


class homeScreen {
  boolean start;
  boolean com;
  PImage img;
  PImage one;
  PImage two;
  PImage obs;
  boolean obson;
  boolean doOnce;
  float x;
  float y;
  homeScreen(float _x,float _y){
     start=false;
     com=true;
     doOnce=true;
     x=_x;
     y=_y;
     background(0);
     //homescreen elements
     img = loadImage("logo.jpg");
     image(img,0,0,750,300);
     one= loadImage("1P.png");
     two= loadImage("2P.png");
     obs= loadImage("obsoff.png");
     fill(0);
     obson=false;
     image(one,100,y/2+20,200,60);
     fill(0);
     image(two,x/2+80,y/2+20,200,60);
     image(obs,x/2-130,y/2+140,300,60);
     noFill();
     stroke(0,0,255);
     strokeWeight(7);
     rect(80, y/2+5, 250, 80);
     stroke(255,0,0);
     strokeWeight(7);
     rect(x/2+55, y/2+5, 250, 80);
     stroke(255);
     rect(x/2-155, y/2+130, 350, 80);
     noStroke();
  }
  boolean obson(){
    return obson;
  }
  void start(){
    start=!start;
  }
  boolean isStart(){
    return start;
  }
  void com(){
    com = !com;
  }
  boolean isCom() {
    return com;
  }
  void mouseReleased(){
    if(mousePressed&&start==false&&mouseX>80&&mouseX<330&&mouseY>y/2+5&&mouseY<y/2+85&&mouseButton==LEFT){
      start();
    }
    if(mousePressed&&start==false&&mouseX>x/2+55&&mouseX<x/2+305&&mouseY>y/2+5&&mouseY<y/2+85&&mouseButton==LEFT){
      start();
      com();
    }
    if(!obson&&mousePressed&&start==false&&mouseX>x/2-155&&mouseX<x/2+195&&mouseY>y/2+130&&mouseY<y/2+210&&mouseButton==LEFT){
        //choosing whether to use obstacles or not use obstacles
        obs=loadImage("obson.png");
        obson=true;
        mousePressed=false;
    }
    else if(obson&&mousePressed&&start==false&&mouseX>x/2-155&&mouseX<x/2+195&&mouseY>y/2+130&&mouseY<y/2+210&&mouseButton==LEFT){
      obs=loadImage("obsoff.png");
      obson=false;
      mousePressed=false;
    }
  
  }
  void update() {
    background(0);
    image(img,0,0,750,300);
     fill(0);
     image(one,100,y/2+20,200,60);
     fill(0);
     image(two,x/2+80,y/2+20,200,60);
     image(obs,x/2-130,y/2+140,300,60);
     noFill();
     stroke(0,0,255);
     strokeWeight(7);
     rect(80, y/2+5, 250, 80);
     stroke(255,0,0);
     strokeWeight(7);
     rect(x/2+55, y/2+5, 250, 80);
     stroke(255);
     rect(x/2-155, y/2+130, 350, 80);
     noStroke();
    //fill(255);
    //rect(x/2 - 50, y/2 - 10, 125, 50);
    //rect(x/2 - 50, y/2 + 70, 125, 50);
  }

}
class InstructionScreen{
  boolean start;
  boolean com;
  PImage wasd;
  PImage arrows;
  PImage one;
  PImage two;
  PImage st;
  PImage shift;
  PImage ctrl;
  float x;
  float y;
  InstructionScreen(float _x,float _y,boolean c){
     // all the images for the instruction screen are loaded here
     start=false;
     com=c;
     x=_x;
     y=_y;
     st = loadImage("start.png");
     one= loadImage("1Pl.png");
     two= loadImage("2Pl.png");
     wasd= loadImage("WASD.png");
     arrows= loadImage("Arrows.png");
     shift=loadImage("shift.png");
     ctrl=loadImage("ctrl.png");
  }
  //is the other player computer driven
  void isCom(boolean c){
    com=c;
  }
  void display(){
    //this is where the control image is displayed
    background(0);
     fill(0);
     image(one,x-280,30,200,60);
     image(arrows,x-280,90,200,200);
     image(ctrl,x-240,300,100,50);
     if(!com){
    fill(255);
     textSize(20);
     text("Speed"+"\n"+ "Boost:",0,320);
     image(shift,120,300,100,50);
     image(two,80,30,200,60);
     image(wasd,70,90,200,200);
     }
     String s="Control a light cycle to make your opponent crash Running into a filled"+"\n"+
               "space on the map causes a cycle to crash. Each player has 3 lives";
     fill(255);
     textSize(20);
     text("Speed"+"\n"+ "Boost:",x/2,320);
     text(s,30,390);
     fill(0);
     image(st,x/2-90,y/2+170,200,60);
     noFill();
     stroke(255);
     strokeWeight(7);
     rect(x/2-110, y/2+160, 250, 80);
     noStroke();
  }
  void start(){
    start=!start;
  }
  boolean isStart(){
    return start;
  }
  void mouseClicked(){
    if(mousePressed&&start==false&&mouseX>x/2-110&&mouseX<x/2+90&&mouseY>y/2+160&&mouseY<y/2+240&&mouseButton==LEFT){
      start();
    }
  }
}
class ComCycle extends Cycle {
  Cycle enemy;
  
  ComCycle(int _x, int _y, int n, int mX, int mY, Cycle c, Arena a) {
    super(_x, _y, n, mX, mY, a);
    enemy = c;
  }
  //the changeing directions for the comcycle is recursive
  void changeDirection(int dir) {
    if(dir == 0 && getVelocity().y == 0) {
      super.up();
      if(isCollide(3)){
       changeDirection(1);
      }
    }
    if(dir == 1 && getVelocity().y == 0) {
      super.down();
      if(isCollide(2)){
       changeDirection(2);
      }
    }
    if(dir == 2 && getVelocity().x == 0) {
      super.left();
      if(isCollide(1)){
       changeDirection(3);
      }
    }
    if(dir == 3 && getVelocity().x == 0) {
      super.right();
      if(isCollide(0)){
        changeDirection(0);
      }
    }
  }
  // the comcycle update method detects whats immediately ahead of it
  void update() {
    
    int dir=0;
      if (velocity.x > 0) {
        if(isCollide(0)) {
          dir = (int)random(3);
          changeDirection(dir);
        }
        if(getNextX() >= ar.arena.length - 40) {
          if(super.getY() - 20 <= 3) {
            dir = 1;
          } else if (super.getY() + 42 >= getArena().arena[0].length) {
            dir = 0;
          } else {
            dir = (int)random(2);
          }
          changeDirection(dir);
        }
      } else if (velocity.x < 0) {
      if (isCollide(1)){
        dir = (int)random(3);
        int[] dirs = {0, 1, 3};
        changeDirection(dirs[dir]);
      }
      if(getNextX() <= 30) {
        if (super.getY() - 20 <= 3) {
          dir = 1;
        } else if (super.getY() + 42 >= getArena().arena[0].length) {
          dir = 0;
        } else {
          dir = (int)random(2);
        }
        changeDirection(dir);
      }
    } else if (velocity.y > 0) {
      if(isCollide(2)) {
        dir = (int)random(3);
        int[] dirs = {0, 2, 3};
        changeDirection(dirs[dir]);
      }

      if(getNextY() + 42 > ar.arena[0].length) {          
        if(super.getX() - 20 <= 3) {
          dir = 3;
        } else if (super.getX() + 42 >= getArena().arena[0].length) {
          dir = 2;
        } else {
          dir = (int)random(2, 4);
        }
        changeDirection(dir);
      }
    } else if (velocity.y < 0) {
      if(isCollide(3)) { 
        dir = (int)random(1, 4);
        changeDirection(dir);
      }
      if(getNextY() <= 24) {
        if(super.getX() - 20 <= 3) {
          dir = 3;
        } else if (super.getX() + 42 >= getArena().arena[0].length) {
          dir=2;
        } else {
          dir = (int)random(2, 4);
        }
        changeDirection(dir);
      }
    }
    super.update();
  }
}
