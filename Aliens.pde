public class Aliens {
  private int x;
  private int y;
  private int size;
  private boolean beam;
  private int stop;
  
  public Aliens() {
    x = 400;
    y = 20;
    size = 50;
    beam = false;
    stop = rand.nextInt(800);
  }
  
  public void enter() {
    spaceShip(x, y, size, beam);
    if (y < 50) {
      y++;
    }
    if (size > 10) {
      size -= 0.5;
    } else {
      beam = true;
    }
  }
  
  public void hover() {
    if (x < stop) {
      x++;
    } else if (x > stop) {
      x--;
    } else {
      stop = rand.nextInt(800);
    }
  }
}