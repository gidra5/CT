ArrayList<Window> windows=new ArrayList<Window>();
Ellipse[] bgMenu=new Ellipse[50];
void circlesOnBackground()
{
  for(int i=0;i<bgMenu.length;i++)
    bgMenu[i].callAll();
}
class Ellipse implements Gameplay
{
  float x,y,r,dr;
  final float R;
  color c=color(random(255),random(255),random(255));
  Ellipse(float r)
  {
    dr=random(10,50);
    x=random(r/2,displayWidth-r/2);
    y=random(r/2,displayHeight-r/2);
    while(x<226+r/2 && y<426+r/2)
    {
      x=random(r/2,displayWidth-r/2);
      y=random(r/2,displayHeight-r/2);
    }
    R=r;
    this.r=random(0,r);
    k=int(round(random(-1,1)));
    if(k==0)
    k=-1;
  }
  void display()
  {
    fill(c);
    ellipse(x,y,r,r);
  }
  void onPressed()
  {
    if(pressed())
    {
      k=-1;
      r=random(0,R);
      x=random(R/2,displayWidth-R/2);
      y=random(R/2,displayHeight-R/2);
      while(x<226+R/2 && y<426+R/2)
      {
        x=random(R/2,displayWidth-R/2);
        y=random(R/2,displayHeight-R/2);
      }
      c=color(random(50,255),random(50,255),random(50,255));
      mousePressed=false;
    }
  }
  boolean pressed()
  {
    return (dist(x,y,mouseX,mouseY)<r && mousePressed);
  }
  private int k;
  void special()
  {
    if(r>R)
    {
      k*=-1;
      r=R;
    }
    if(r>0)
      r+=k*dr*loopTime/1000;
    else
    {
      k=1;
      r=random(0,R);
      x=random(R/2,displayWidth-R/2);
      y=random(R/2,displayHeight-R/2);
      while(x<226+R/2 && y<426+R/2)
      {
        x=random(R/2,displayWidth-R/2);
        y=random(R/2,displayHeight-R/2);
      }
      c=color(random(50,255),random(50,255),random(50,255));
    }
  }
  void callAll()
  {
    display();
    special();
    onPressed();
  }
}
interface Gameplay
{
  void display();
  void onPressed();
  boolean pressed();
  void special();
  void callAll();
}