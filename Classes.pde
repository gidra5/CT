abstract class Button
{
  PGraphics buttonPg, buttonPressedPg;
  float x, y, h, w, sra=15, textSize=0;
  color c, cPressed;
  String s="";
  Button(float cx, float cy, float cw, float ch, color cc)
  {
    x=cx;
    y=cy;
    w=cw;
    h=ch;
    c=cc;
    cPressed=color(red(c)+10, green(c)+20, blue(c)+30);
    buttonPg=createGraphics(int(w+1), int(h+1));
    buttonPressedPg= createGraphics(int(w+1), int(h+1));
  }
  void setupRender()
  {
    buttonPg.beginDraw();
    buttonPg.textAlign(CENTER, CENTER);
    buttonPg.fill(c);
    buttonPg.rect(1, 0, w, h, sra);
    buttonPg.fill(0);
    buttonPg.textSize(textSize);
    buttonPg.text(s, w/2+1, h/2);
    buttonPg.endDraw(); 
    buttonPressedPg.beginDraw();
    buttonPressedPg.textAlign(CENTER, CENTER);
    buttonPressedPg.fill(cPressed);
    buttonPressedPg.rect(1, 0, w, h, sra);
    buttonPressedPg.fill(0);
    buttonPressedPg.textSize(textSize);
    buttonPressedPg.text(s, w/2+1, h/2);
    buttonPressedPg.endDraw();
  }
  void setSmoothRectAngles(float smoothness) { 
    sra=smoothness;
  }
  void setTextOnButton(String newText) { 
    s=newText;
  }
  void setTextSize(float size) { 
    textSize=size;
  }
  boolean pressed()
  {
    if (mousePressed && mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h)
      return true;
    else
      return false;
  }
  void displayButton()
  {
    if (!pressed())
      image(buttonPg, x, y);
    else
      image(buttonPressedPg, x, y);
  }
  abstract void onPressed();
}

abstract class Window 
{
  ArrayList<Object> objects=new ArrayList<Object>();
  abstract void display();
  abstract void listen();
  void addObject(Object obj)
  {
    objects.ensureCapacity(objects.size()+1);
    objects.add(obj);
  }
}
class Circle extends Ellipse
{
  float ms;
  Circle(float x, float y, float r, float ms)
  {
    super(r);
    this.ms=ms;
    this.dr=R*(1000/ms);
    this.x=x;
    this.y=y;
    this.r=r;
  }
  @Override
    void onPressed()
  {
    if (pressed())
    {
      score++;
      ms-=12/log(3+score);
      println(ms);
      dr=R*(1000/ms);
      r=R;
      x=random(R/2, displayWidth-R/2);
      y=random(R/2, displayHeight-R/2);
      c=color(random(50,255), random(50,255), random(50,255));
      mousePressed=false;
      paused=false;
    }
  }
  @Override
    void special()
  {
    if(!paused)
    {
    if (r>0)
      r-=dr*loopTime/1000;
    else
    {
      if (score>0)
        score--;
      r=R;
    }
    }
  }
}
class Swipe extends Circle
{
  float r2, x2, y2;
  Swipe(float x, float y, float r, float dr)
  {
    super(x, y, r, dr);
    r2=r;
  }
}
