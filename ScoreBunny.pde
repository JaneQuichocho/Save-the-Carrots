class ScoreBunny {
  private int x;
  private int y;
  private float size;
  
  public ScoreBunny(int x, int y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  public void play(int face) {
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
    rotate(radians(90));
    ellipse(0, 0, 10 * size, 3 * size);
    popMatrix();
    
    // body
    ellipse(x + 5, y, 12 * size, 15 * size);
    
    // arms
    pushMatrix();
    translate(x + 6 * size, y - 2 * size);
    rotate(radians(135));
    ellipse(0, 0, 9 * size, 3 * size);
    popMatrix();
    
    fill(156, 114, 56);  // scoreboard
    rect(x + 0.5 * size, y - 5 * size, 8 * size, 6 * size);
    
    fill(255);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(x - 1.5 * size, y - 3 * size);
    rotate(radians(135));
    ellipse(0, 0, 9 * size, 3 * size);
    popMatrix();
    
    noStroke();
    rect(x - 5 * size, y - 2.5 * size, 4 * size, 5 * size);
    if (face == 1) {
      face1();
    }
    if (face == 2) {
      face2();
    }
    if (face == 3) {
      face3();
    }
  }
  
  void face1() {
    fill(255, 130, 143);
    arc(x + 1.5 * size, y - 7.5 * size, 6 * size, 8 * size,
        PI, TWO_PI);
    fill(0);
    ellipse(x - 0.5 * size, y - 13 * size, size,
        1.5 * size);
    ellipse(x + 3.5 * size, y - 13 * size, size,
        1.5 * size);
  }
  
  void face2() {
    fill(255, 130, 143);
    ellipse(x + 1.5 * size, y - 9.5 * size, 3 * size, 3 * size);
    fill(0);
    ellipse(x - 0.5 * size, y - 13 * size, 1.5 * size, 
      1.5 * size);
    ellipse(x + 3.5 * size, y - 13 * size, 1.5 * size, 
      1.5 * size);
  }
  
  void face3() {
    fill(255, 130, 143);
    arc(x + 2 * size, y - 11 * size, 5 * size, 8 * size,
        0, PI);
    fill(0);
    ellipse(x + 0.5 * size, y - 13 * size, 2 * size,
        2.5 * size);
    ellipse(x + 3.5 * size, y - 13 * size, 2 * size,
        2.5 * size);
  }
}