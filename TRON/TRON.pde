import processing.sound.*;
import java.util.*;
import javax.swing.*;

Arena a;
Cycle c; // 1 player
Cycle c2; // 2 player
homeScreen h;
PGraphics pg;
SoundFile d;
SoundFile e;


void setup() {
  d=new SoundFile(this,"derez.mp3");
  e=new SoundFile(this,"bike.wav");
  size(750,550);
  pg = createGraphics(760, 560);
  h=new homeScreen(760,560);
  c = new Cycle(690, 280, 0,750,550,a);
  c2 = new ComCycle(50, 280, 1,750,550,c,a);
  ArrayList<Cycle> cyc = new ArrayList();
  cyc.add(c);
  cyc.add(c2);
  a = new Arena(750,550,cyc);
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
    // speed boost
    if(keyCode == '/') {
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
    if(keyCode == 'Q') {
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
  void mousePressed(){
    int x=a.arena.length;
    int y=a.arena[0].length;
    if(mousePressed&&(c.GameOver==true||c2.GameOver==true)&&mouseX>x/2-75&&mouseX<x/2+50&&mouseY>y/2+70&&mouseY<y/2+130&&mouseButton==LEFT){
      c = new Cycle(690, 280, 0,750,550,a);
      c2 = new ComCycle(50, 280, 1,750,550,c,a);
      restart();
      h.start();
      h=new homeScreen(760,560);
    }
  }
void restart(){
  c.location=new PVector(690,280);
  c2.location=new PVector(50,280);
  c.velocity=new PVector(-2,0);
  c2.velocity=new PVector(2,0);
  ArrayList<Cycle> cyc = new ArrayList();
  cyc.add(c);
  cyc.add(c2);
  a = new Arena(750,550,cyc);
  c.addArena(a);
  c2.addArena(a);
}
void draw(){ 
  if(h.isStart()){
   background(0, 0, 54);
   noStroke();
   a.display();
   if (c.Restart == false && c2.Restart == false) {
     
     a.update();
    //System.out.println(a.obs[0]-50);
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
    // computer
  } else {
    a.update();
    fill(0,0,255);
    c.display();
    fill(255,0,0);
    c2.display();
    if (c.Restart == true || c2.Restart == true) {
      d.play();
      if (c.lives < 0 || c2.lives < 0) {
        pg.beginDraw();
        pg.background(0,0,0,200);
        pg.fill(255,0,0);
        pg.textSize(50);
        pg.textAlign(CENTER, CENTER);
        pg.text("Game Over", 350, 250);
        if(c.GameOver==true&&c2.GameOver==true){
          pg.fill(255,0,255);
          pg.textSize(30);
          pg.textAlign(CENTER, CENTER);
          pg.text("DRAW", 350, 300);
        }
        else if(c.GameOver==false){
          pg.fill(0,0,255);
          pg.textSize(30);
          pg.textAlign(CENTER, CENTER);
          pg.text("Player 1 Wins", 350, 300);
        } 
        else{
          pg.fill(255,0,0);
          pg.textSize(30);
          pg.textAlign(CENTER, CENTER);
          pg.text("Player 2 Wins", 350, 300);
        }
        int x=a.arena.length;
         int y=a.arena[0].length;
         pg.fill(255);
         pg.rect(x/2-75,y/2+70,100,50);
         pg.fill(0);
         pg.textSize(24);
         pg.text("Restart",x/2-30,y/2+90);
         mousePressed();
         pg.endDraw();
        image(pg,0,0);
      } else {
        restart();
         c.Restart = false;
         c2.Restart = false;
        // restart button here 
      }

    }
  }
 }
 else{
     h.mouseClicked();
  if(!h.isCom()){
     c2 = new Cycle(50, 280, 1,750,550,a);
   } 
     ArrayList<Cycle> cyc = new ArrayList();
  cyc.add(c);
  cyc.add(c2);
  a = new Arena(750,550,cyc);
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
  Cycle(int _x, int _y, int n,int mX, int mY,Arena a){
    num = n;
    location = new PVector(_x, _y);
    livesX=_x;
    livesY=_y-200;
    maxX=mX;
    maxY=mY;
    ar=a;
    lives = 5;
    GameOver = false;
    if (n == 0) {
      velocity = new PVector(-2, 0);
    } else {
      velocity = new PVector(2, 0); 
    }
    rect(location.x, location.y, 20, 10);
  }
  void addArena(Arena a) {
    ar = a;
  }
  void update() {
    //OGlives = lives;
    if (lives >= 0) {
      text(lives, livesX, livesY);
      if (velocity.x > 0) {
        boolean collide=false;
        for(int i=18;i>=0&&!collide;i-=2){
           if(ar.arena[(int)getNextX()+i][(int)location.y]!=0){
             collide=true;
           }
        }
        if(location.x < maxX - 41&&!collide){
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
    else if (velocity.x < 0) {

        boolean collide=false;
        for(int i=18;i>=0&&!collide;i-=2){
           if(ar.arena[(int)getNextX()-i][(int)location.y]!=0){
             collide=true;
           }
        }
      if (location.x >= 21 && !collide){
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
        boolean collide=false;
        for(int i=18;i>=0&&!collide;i-=2){
           if(ar.arena[(int)location.x][(int)getNextY()+i]!=0){
             collide=true;
           }
        }
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
        boolean collide=false;
        for(int i=14;i>=0&&!collide;i-=2){
           if(ar.arena[(int)location.x][(int)getNextY()-i]!=0){
             collide=true;
           }
        }
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

  }
  
  // accessors
  Arena getArena(){
    return ar;
  }
  PVector getVelocity(){
    return velocity;
  }
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
      Random rand=new Random();
      obs[0]=(int)((int)rand.nextInt((arena.length-40)/2)*2);
      obs[1]=(int)((int)rand.nextInt((arena[0].length-40)/2)*2);
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
      /*if(arena[obs[0]][obs[1]]<=-1||obs[0]==0||obs[1]==0){
        createObstacles();
      }
      else{
        arena[obs[0]][obs[1]]-=.1;
        if(arena[obs[0]][obs[1]]<=-1){
            arena[obs[0]][obs[1]]=-1;
        }
      }*/
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
  boolean isAvail(float x,float y){
    if(x >= arena.length || x < 0 || y >= arena[(int)x].length || y < 0 || arena[(int)x][(int)y] == 1) {
      return false;
    }
      return true;
  }
}
class homeScreen{
  boolean start;
  boolean com;
  PImage img;
  float x;
  float y;
  homeScreen(float _x,float _y){
     start=false;
     com=true;
     x=_x;
     y=_y;
     background(0);
     img = loadImage("logo.jpg");
     image(img,0,0,750,350);
     fill(255);
     rect(x/2-50,y/2,125,50);
     fill(0);
     textSize(24);
     text("1 Player",x/2-40,y/2+30);
     fill(255);
     rect(x/2-50,y/2+70,125,50);
     fill(0);
     textSize(24);
     text("2 Player",x/2-40,y/2+100);
  }
  void start(){
    start=!start;
  }
  boolean isStart(){
    return start;
  }
  void com(){
    com=!com;
  }
  boolean isCom(){
    return com;
  }
  void mouseClicked(){
    if(mousePressed&&start==false&&mouseX>x/2-50&&mouseX<x/2+50&&mouseY>y/2&&mouseY<y/2+50&&mouseButton==LEFT){
      start();
    }
    if(mousePressed&&start==false&&mouseX>x/2-50&&mouseX<x/2+50&&mouseY>y/2+70&&mouseY<y/2+120&&mouseButton==LEFT){
      start();
      com();
    }
  }
  void update(){
    background(0);
    fill(255);
    rect(x/2-50,y/2-10,125,50);
    rect(x/2-50,y/2+70,125,50);
  }

}
class ComCycle extends Cycle{
  Cycle enemy;
  ComCycle(int _x, int _y, int n,int mX, int mY,Cycle c,Arena a){
    super(_x, _y, n, mX, mY, a);
    enemy=c;
  }
  float getDistance(Cycle c,int direction){
    float dist=0;
    if(direction==0){
      dist=abs(c.getNextY()-(this.getY()-3))+abs(c.getNextX()-this.getX());
    }
    if(direction==1){
      dist=abs(c.getNextY()-(this.getY()+3))+abs(c.getNextX()-this.getX());
    }
    if(direction==2){
      dist=abs(c.getNextY()-this.getY())+abs(c.getNextX()-(this.getX()-3));
    } 
    if(direction==3){
      dist=abs(c.getNextY()-this.getY())+abs(c.getNextX()-(this.getX()+3));
    }
    return dist;  
  }
  void changeDirection(int dir){
     if(dir==0&&getVelocity().y==0){
       super.up();
    }
    if(dir==1&&getVelocity().y==0){
      super.down();
    }
    if(dir==2&&getVelocity().x==0){
      super.left();
    }
    if(dir==3&&getVelocity().x==0){
      super.right();
    }
  }
  
  void update(){
    
    int dir=0;
      if (velocity.x > 0) {
        boolean collide=false;
        for(int i=18;i>=0&&!collide;i--){
           if(ar.arena[(int)getNextX()+i][(int)location.y]!=0){
             collide=true;
           }
        }
        if(collide){
          dir=(int)random(3);
          changeDirection(dir);
        }
        if(getNextX()>=ar.arena.length-40){
          if(super.getY()-20<=3){
            dir=1;
          }
          else if(super.getY()+42>=getArena().arena[0].length){
            dir=0;
          }
          else{
            dir=(int)random(2);
          }
          changeDirection(dir);
        }
    }
    else if (velocity.x < 0) {
        boolean collide=false;
        for(int i=18;i>=0&&!collide;i--){
           if(ar.arena[(int)getNextX()-i][(int)location.y]!=0){
             collide=true;
           }
        }
      if (collide){
         dir=(int)random(3);
        int[] dirs={0,1,3};
        changeDirection(dirs[dir]);
      }
      if(getNextX()<=30){
          if(super.getY()-20<=3){
            dir=1;
          }
          else if(super.getY()+42>=getArena().arena[0].length){
            dir=0;
          }
          else{
            dir=(int)random(2);
          }
        changeDirection(dir);
      }
    } else if (velocity.y > 0) {
        boolean collide=false;
        for(int i=18;i>=0&&!collide;i--){
           if(ar.arena[(int)location.x][(int)getNextY()+i]!=0){
             collide=true;
           }
        }
      if(collide) {
        dir=(int)random(3);
        int[] dirs={0,2,3};
        changeDirection(dirs[dir]);
      }

      if(getNextY()+42>ar.arena[0].length){          
        if(super.getX()-20<=3){
            dir=3;
          }
          else if(super.getX()+42>=getArena().arena[0].length){
            dir=2;
          }
          else{
           dir=(int)random(2,4);
          }
        changeDirection(dir);
      }
    } else if (velocity.y < 0) {
        boolean collide=false;
        for(int i=18;i>=0&&!collide;i--){
           if(ar.arena[(int)location.x][(int)getNextY()-i]!=0){
             collide=true;
           }
        }
        if(collide) { 
           dir=(int)random(1,4);
           changeDirection(dir);
        }
        if(getNextY() <= 24){
          if(super.getX()-20<=3){
            dir=3;
          }
          else if(super.getX()+42>=getArena().arena[0].length){
            dir=2;
          }
          else{
           dir=(int)random(2,4);
          }
        changeDirection(dir);
        }
    }
    super.update();
  }
}
