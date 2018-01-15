class FlyingCarrots {
  private int count;
  private int num;
  private Point[] position;
  private boolean[] save;
  private int carrotStorm;
  
  
  public FlyingCarrots(int num) {
    construct(num);
    count = 0;
    carrotStorm = 0;
  }
  
  private void construct(int num) {
    this.num = num;
    position = new Point[num];
    save = new boolean[num];
    for (int i = 0; i < num; i++) {
      save[i] = false;
      position[i] = new Point(rand.nextInt(800), 
          rand.nextInt(1000) + 620);
    }
  }
  
  public void play() {
    for (int i = 0; i < num; i++) {
      if (!save[i]) {
        carrot(position[i].x, position[i].y, 5);
        stroke(69, 255, 36);
        if (dist(position[i].x, position[i].y, mouseX, 
            mouseY) <= 30) {
          strokeWeight(4);
          if (mousePressed) {
            count++;
            save[i] = true;
          }
        } else {
          strokeWeight(2);
        }
        noFill();
        ellipse(position[i].x, position[i].y + 10, 60, 60);
      }
    }
  }
  
  public void abduct() {
    for (int i = 0; i < num; i++) {
      if (position[i].y <= -30 && save[i] == false) {
        count--;;
        save[i] = true;
      } else {
        position[i].y -= 2;
      }
    }
  }
  
  public int getScore() {
    return count;
  }
  
  public void changeNum(int num) {
    if (check() && !gameOver()) {
      construct(num);
    }
  }
  
  private boolean check() {
    for (int i = 0; i < num; i++) {
      if (save[i] == false) {
        return false;
      }
    }
    carrotStorm++;
    return true;
  }
  
  public boolean gameOver() {
    return carrotStorm >= 2;
  }
  
}