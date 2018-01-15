/* Save the Carrots! : Alien spaceships have come to
steal all the carrots from the carrot farm! Click on
the carrots to save them. */

import java.util.*;
import java.awt.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Opening Screen
float x = 0;
float y = 400;
PFont font;
Minim minim;
AudioPlayer player;
boolean start = false;

// Gameplay
Random rand = new Random();
int count = 0;
int score = 0;

Aliens aliens1 = new Aliens();
Aliens aliens2 = new Aliens();
Aliens aliens3 = new Aliens();

FlyingCarrots[] carrots = new FlyingCarrots[5];
ScoreBunny scoreBunny = new ScoreBunny(100, 380, 7);
int endScreen = 0;

// End Screens
float theta = 0;

void setup() {
  size(800, 600);
  smooth();
  
  font = loadFont("Chalkboard-Bold-48.vlw");
  minim = new Minim(this);
  player = minim.loadFile("bensound-littleidea.mp3");
  
  for (int i = 0; i < 5; i++) {
    carrots[i] = new FlyingCarrots(10);
  }
}

void draw() {
  if (start == false) {
    openingScreen();
  } else {
    if (carrots[0].gameOver() &&
        carrots[1].gameOver() &&
        carrots[2].gameOver() &&
        carrots[3].gameOver() &&
        carrots[4].gameOver()) {
      background(145, 228, 255);
      player.pause();
      if (endScreen == 0) {
        endScreen1();
      } else if (endScreen == 1) {
        endScreen2();
      } else {
        endScreen3();
      }
    } else {
      playGame();
    }
  }
}

void openingScreen() {
  background(145, 228, 255);
  
  // text
  fill(252, 148, 3);
  textFont(font);
  textSize(72);
  text("Save the Carrots!", 100, 100);
  textSize(24);
  text("Music: Little Idea - Bensound.com", 210, 130);
  text("Click on the flying", 500, 200);
  text("carrots to save them from", 500, 230);
  text("the alien carrot theives.", 500, 260);
  text("Press play to begin!", 500, 290);
  carrotFarm();
  rabbit(100, 300, 7);
  carrot(190, 180, 10);
  pushMatrix();
  translate(730, 55);
  rotate(radians(30));
  spaceShip(0, 0, 5, false);
  popMatrix();
  playButton(400, 230, 7);
}

void carrot(int x, int y, float size) {
  noStroke();
  fill(40, 252, 3);
  
  pushMatrix();
  translate(x - size, y - size);
  rotate(radians(40));
  ellipse(0, 0, 4 * size, 2 * size);
  popMatrix();
  
  pushMatrix();
  translate(x + size, y - size);
  rotate(radians(110));
  ellipse(0, 0, 3 * size, 1.5 * size);
  popMatrix();
  
  fill(252, 148, 3);
  stroke(252, 148, 3);
  strokeWeight(8);
  strokeJoin(ROUND);
  triangle(x - 1.5 * size, y, x + 1.5 * size, y,
      x, y + 5 * size);
}

void rabbit(int x, int y, float size) {
  // head
  fill(255);
  noStroke();
  ellipse(x + 0.5 * size, y - 10 * size, 12 * size, 
      10 * size);
  
  // ears
  pushMatrix();
  translate(x - 5 * size, y - 16 * size);
  rotate(radians(50));
  ellipse(0, 0, 10 * size, 3 * size);
  popMatrix();
  
  pushMatrix();
  translate(x + 0.5 * size, y - 16 * size);
  rotate(radians(50));
  ellipse(0, 0, 10 * size, 3 * size);
  popMatrix();
  
  // body
  pushMatrix();
  translate(x, y);
  rotate(radians(20));
  ellipse(0, 0, 12 * size, 15 * size);
  popMatrix();
  
  // legs
  pushMatrix();
  translate(x - 4 * size, y + 5.5 * size);
  rotate(radians(135));
  ellipse(0, 0, 6 * size, 3 * size);
  popMatrix();
  
  pushMatrix();
  translate(x + 1.5 * size, y + 6.5 * size);
  rotate(radians(135));
  ellipse(0, 0, 6 * size, 3 * size);
  popMatrix();
  
  // arms
  pushMatrix();
  translate(x + 6 * size, y - 2 * size);
  rotate(radians(135));
  ellipse(0, 0, 9 * size, 3 * size);
  popMatrix();
  
  stroke(0);
  strokeWeight(1);
  pushMatrix();
  translate(x - 1.5 * size, y - 3 * size);
  rotate(radians(135));
  ellipse(0, 0, 9 * size, 3 * size);
  popMatrix();
  
  noStroke();
  rect(x - 5 * size, y - 2.5 * size, 4 * size, 5 * size);
  
  // face
  fill(255, 130, 143);
  arc(x + 2 * size, y - 7.5 * size, 6 * size, 8 * size,
      PI, TWO_PI);
  fill(0);
  ellipse(x - 0.5 * size, y - 13 * size, 1.5 * size,
      2 * size);
  ellipse(x + 3.5 * size, y - 13 * size, 1.5 * size,
      2 * size);  
}

void spaceShip(int x, int y, float size, boolean beam) {
  stroke(0);
  strokeWeight(1);
  fill(69, 255, 36);
  ellipse(x, y, 12 * size, 12 * size);
  
  fill(87);
  ellipse(x, y + 2 * size, 20 * size, 9 * size);
  
  if (beam) {
    stroke(69, 255, 36);
    strokeWeight(4);
    line(x - 7.5 * size, y + 4 * size, x - 15 * size, 
        y + 12 * size);
    line(x + 7.5 * size, y + 4 * size, x + 15 * size, 
        y + 12 * size);
  }
}

void playButton(int x, int y, float size) {
  noStroke();
  if (dist(x, y, mouseX, mouseY) < 10 * size) {
    stroke(115, 255, 152);
    strokeWeight(6);
    if (mousePressed) {
      player.loop();
      start = true;
    }
  }
  fill(255);
  ellipse(x, y, 20 * size, 20 * size);
  fill(115, 255, 152);
  triangle(x - 3.5 * size, y - 5 * size, x - 3.5 * size, 
      y + 5 * size, x + 6.5 * size, y);
}

void floatCarrots(int index) {
  if (count >= 100) {
    carrots[index].play();
    carrots[index].abduct();
    carrots[index].changeNum(50);
  }
}

void carrotFarm() {
  strokeWeight(6);
  for (int i = 0; i < 800; i++) {
    x  = i;
    y = 10 * sin(x / 50) + 400;
    stroke(115, 80, 42);
    line(x, y, x, 600);
    if (i <= 5) {
      carrot(60 + i * 150, 385, 10);
    }
  }
  for (int i = 0; i < 800; i++) {
    x = i;
    y = 10 * sin(x / 50) + 470;
    stroke(150, 105, 56);
    line(x, y, x, 600);
    if (i <= 5) {
      carrot(60 + i * 150, 450, 10);
    }
  }
  for (int i = 0; i < 800; i++) {
    x = i;
    y = 10 * sin(x / 50) + 540;
    stroke(115, 80, 42);
    line(x, y, x, 600);
    if (i <= 5) {
      carrot(60 + i * 150, 520, 10);
    }
  }
  for (int i = 0; i < 800; i++) {
    x = i;
    y = 10 * sin(x / 50) + 590;
    stroke(150, 105, 56);
    line(x, y, x, 600);
    if (i <= 5) {
      carrot(60 + i * 150, 580, 10);
    }
  }
}

void playGame() {
  count++;
  background(145, 228, 255);
  
  // Score Bunny
  if (score <= 20) {
    endScreen = 0;
    scoreBunny.play(1);
  } else if (score <= 50) {
    endScreen = 1;
    scoreBunny.play(2);
  } else {
    endScreen = 2;
    scoreBunny.play(3);
  }
  
  floatCarrots(0);
  strokeWeight(6);
  for (int i = 0; i < 800; i++) {
    x  = i;
    y = 10 * sin(x / 50) + 400;
    stroke(115, 80, 42);
    line(x, y, x, 600);
  }
  floatCarrots(1);
  for (int i = 0; i < 800; i++) {
    x = i;
    y = 10 * sin(x / 50) + 470;
    stroke(150, 105, 56);
    line(x, y, x, 600);
  }
  floatCarrots(2);
  for (int i = 0; i < 800; i++) {
    x = i;
    y = 10 * sin(x / 50) + 540;
    stroke(115, 80, 42);
    line(x, y, x, 600);
  }
  floatCarrots(3);
  for (int i = 0; i < 800; i++) {
    x = i;
    y = 10 * sin(x / 50) + 590;
    stroke(150, 105, 56);
    line(x, y, x, 600);
  }
  floatCarrots(4);
  
  // Aliens enter
  aliens1.enter();
  aliens1.hover();
  if (count >= 70) {
    aliens2.enter();
    aliens2.hover();
  }
  if (count >= 140) {
    aliens3.enter();
    aliens3.hover();
  }
  
  // Scoring
  score = 0;
  for (int i = 0; i < 5; i++) {
    score += carrots[i].getScore();
  }
  
  fill(0);
  textSize(15);
  text("SCORE", 110, 360);
  text(score, 120, 380);
}

void endScreen1() {
  fill(252, 148, 3);
  textSize(60);
  textFont(font);
  text("You didn't save enough carrots...", 30, 100);
  text("Score: " + score, 120, 170);
  
  fill(255);
  noStroke(); 
  endScreenBunny(395, 420, 40);
  
  // face
  pushMatrix();
  translate(395, 420);
  rotate(radians(40));
  fill(0);
  stroke(0);
  strokeJoin(ROUND);
  strokeWeight(3);
  line(-35, -120, -20, -105);
  line(-35, -105, -20, -120);
  
  line(20, -120, 35, -105);
  line(20, -105, 35, -120);
  
  ellipse(0, -65, 30, 50);
  fill(255);
  noStroke();
  ellipse(0, -62, 35, 50);
  popMatrix();
}

void endScreen2() {
  fill(252, 148, 3);
  textSize(60);
  textFont(font);
  text("You managed to save quite a few", 30, 100);
  text("carrots! Good job!", 30, 170);
  text("Score: " + score, 120, 240);
  endScreenBunny(500, 450, 0);
  
  // face
  fill(0);
  ellipse(475, 330, 10, 20);
  ellipse(525, 330, 10, 20);
  fill(255, 130, 143);
  ellipse(500, 360, 30, 30);
  fill(255);
  ellipse(500, 357, 30, 30);
  
  // carrots
  carrot(400, 400, 10);
  carrot(600, 400, 10);
}

void endScreen3() {
  fill(252, 148, 3);
  textSize(60);
  textFont(font);
  text("You saved the carrot farm!", 30, 50);
  text("Score: " + score, 120, 120);
  
  endScreenBunny(400, 410, 0);
  pushMatrix();
  translate(400, 370);
  rotate(radians(theta));
  pushMatrix();
  translate(0, 0);
  for (int i = 0; i < 8; i++) {
    rotate(radians(i * 45));
    carrot(0, -230, 7);
  }
  popMatrix();
  popMatrix();
  theta += 1;
  
  // face
  fill(0);
  noStroke();
  ellipse(375, 300, 15, 30);
  ellipse(425, 300, 15, 30);
  fill(255);
  ellipse(375, 305, 15, 30);
  ellipse(425, 305, 15, 30);
  
  fill(255, 130, 143);
  arc(400, 315, 50, 70, 0, PI);
  
}

void endScreenBunny(int x, int y, int rotate) {
  fill(255);
  noStroke();
  pushMatrix();
  translate(x, y);
  rotate(radians(rotate));
  
  // body
  ellipse(0, 0, 120, 150);
  
  // head
  ellipse(0, -100, 120, 100);
  
  // ears
  pushMatrix();
  translate(-50, -160);
  rotate(radians(225));
  ellipse(0, 0, 100, 30);
  popMatrix();
  
  pushMatrix();
  translate(50, -160);
  rotate(radians(135));
  ellipse(0, 0, 100, 30);
  popMatrix();
  
  // legs
  ellipse(-35, 55, 30, 60);  
  ellipse(35, 55, 30, 60);
  
  // arms
  ellipse(50, -20, 90, 30);
  ellipse(-50, -20, 90, 30);
  popMatrix();
}