class Link
{
  int index;
  
  PVector position;
  
  int size;
  
  
  Link(int index, int size, PVector position)
  {
    this.index = index;
    this.size = size + (int) random(-9, 9);
    this.position = position;
  }
  
  
  void update(PVector position)
  {
    this.position = position;
  }
  
  
  void display()
  {
    fill(100, 50);
    ellipse(position.x, position.y, size, size);
  }
  
  
  
}