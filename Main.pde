final int WINDOW_MENU=0,WINDOW_OPTIONS=1,WINDOW_PLAY=2;
int currentWindow;
long runTime=0,loopTime,overallLoopTime;
final long startTime=System.currentTimeMillis();
PGraphics menusBG,scoresBG;
boolean showScores=false,playing=false,paused=true;
int score=0;
  
void setup()
{
  Circle circle=new Circle(displayWidth/2,displayHeight/2,350,2250);
  for(int i=0;i<bgMenu.length;i++)
    bgMenu[i]=new Ellipse(3*i+90);
  size(displayWidth, displayHeight); 
  orientation(LANDSCAPE);
  
  scale(displayWidth/1280,displayHeight/800);
  
  scoresBG=createGraphics(401,600);
  scoresBG.beginDraw();
  scoresBG.fill(120,175,25);
  scoresBG.rect(1,0,400,600,20);
  scoresBG.endDraw();
  
  menusBG=createGraphics(201,401);
  menusBG.beginDraw();
  menusBG.fill(120,175,25);
  menusBG.rect(1,0,200,400,10);
  menusBG.endDraw();
  
  Button Play,Options,Exit,Back,Scores,Pause,StartPlaying,BackToMenu;
  
  BackToMenu=new Button(width-200,0,140,50,color(0,0,255))
  {
    public void onPressed()
    {
      currentWindow=WINDOW_MENU;
      mousePressed=false;
    }
    @Override
    public void displayButton()
    {
      if(paused)
      {
      if (!pressed())
        image(buttonPg, x, y);
      else
        image(buttonPressedPg, x, y);
      }
    }
  };
  StartPlaying=new Button((width-700)/2,(height-700)/2,700,700,color(random(50,255),random(50,255),random(50,255)))
  {
    public void onPressed()
    {
      playing=true;
      paused=false;
      currentWindow=WINDOW_PLAY;
    }
    @Override
    public void setupRender()
    {
    buttonPg.beginDraw();
    buttonPg.textAlign(CENTER,CENTER);
    buttonPg.fill(c);
    buttonPg.ellipse(w/2,h/2,w/2,h/2);
    buttonPg.fill(0);
    buttonPg.textSize(textSize);
    buttonPg.text(s,w/2+1,h/2);
    buttonPg.endDraw(); 
    buttonPressedPg.beginDraw();
    buttonPressedPg.endDraw();
    }
    @Override
    public void displayButton()
    {
      if(!playing)
      {
        if (!pressed())
          image(buttonPg, x, y);
        else
          image(buttonPressedPg, x, y);
      }
    }
  };
  Pause=new Button(width-50,0,50,50,color(0,0,255))
  {
    public void onPressed()
    {
      paused=true;
      mousePressed=false;
    }
    @Override
    public void setupRender()
    {
    buttonPg.beginDraw();
    buttonPg.textAlign(CENTER,CENTER);
    buttonPg.fill(c);
    buttonPg.rect(1,0,w,h);
    buttonPg.fill(255);
    buttonPg.rect(w/3-3,5,6,40);
    buttonPg.rect(w*2/3-3,5,6,40);
    buttonPg.endDraw(); 
    buttonPressedPg.beginDraw();
    buttonPressedPg.textAlign(CENTER,CENTER);
    buttonPressedPg.fill(cPressed);
    buttonPressedPg.rect(1,0,w,h);
    buttonPressedPg.fill(255);
    buttonPressedPg.rect(w/3-3,5,6,40);
    buttonPressedPg.rect(w*2/3-3,5,6,40);
    buttonPressedPg.endDraw();
    }
  };
  Scores=new Button(50,250,150,50,color(110,25,120))
  {
    public void onPressed()
    {
      mousePressed=false;
      if(!showScores)
      showScores=true;
      else showScores=false;
    }
  };
  Back=new Button(50,350,150,50,color(110,25,120))
  {
    public void onPressed()
    {
      mousePressed=false;
      if(currentWindow==WINDOW_OPTIONS || currentWindow==WINDOW_PLAY)
      currentWindow=WINDOW_MENU;
    }
  };
  Play=new Button(50,50,150,50,color(110,25,120)) 
  {
    public void onPressed()
    {
      mousePressed=false;
      currentWindow=WINDOW_PLAY;
    }
  };
  Options=new Button(50,150,150,50,color(110,25,120)) 
  {
    public void onPressed()
    {
      mousePressed=false;
      currentWindow=WINDOW_OPTIONS;
    }
  };
  Exit=new Button(50,350,150,50,color(110,25,120))
  {
    public void onPressed()
    {
      mousePressed=false;
      //exit();
    }
  };
  
  BackToMenu.setTextOnButton("Back");
  BackToMenu.setTextSize(25);
  
  StartPlaying.setTextOnButton("Play");
  StartPlaying.setTextSize(25);
  
  Pause.setTextOnButton("");
  Pause.setTextSize(25);
  
  Play.setTextOnButton("Play");
  Play.setTextSize(25);
  
  Options.setTextOnButton("Options");
  Options.setTextSize(25);

  Exit.setTextOnButton("Exit");
  Exit.setTextSize(25);
  
  Back.setTextOnButton("Back");
  Back.setTextSize(25);
  
  Scores.setTextOnButton("Scores");
  Scores.setTextSize(25);
  
  Window menu,options,play,scores;
  
  menu= new Window()
  {
    public void display()
    {
      for(Object obj : objects)
      {
        if(obj instanceof Button)
        {
          ((Button)obj).displayButton();
          continue;
        }
        else if(obj instanceof PGraphics)
          set(25,25,(PGraphics)obj);
      }
    }
    public void listen()
    {
      
    }
  };
  options=new Window()
  {
   public void display()
    {
      circlesOnBackground();
      for(Object obj : objects)
      {
        if(obj instanceof Button)
        {
          ((Button)obj).displayButton();
          continue;
        }
        else if(obj instanceof PGraphics)
          image((PGraphics)obj,25,25);
      }
    }
    public void listen()
    {
      
    }
  };
  play=new Window()
  {
   public void display()
    {
      textAlign(LEFT,TOP);
      textSize(25);
      text(score,0,0);
      for(Object obj : objects)
      {
        if(obj instanceof Button)
        {
          ((Button)obj).displayButton();
          continue;
        }
        if(playing)
        {
          if(obj instanceof Circle)
            ((Circle)obj).callAll();
        }
      }
    }
    public void listen()
    {
      
    }
  };
  scores=new Window()
  {
    public void display()
    {
      for(Object obj : objects)
      {
        try{
          Button button=(Button)obj;
          button.displayButton();
          if(button.pressed())
          button.onPressed();
          continue;
        }
        catch( java.lang.ClassCastException e)
        {}
      }
    }
    public void listen()
    {
      
    }
  };
  
  BackToMenu.setupRender();
  Pause.setupRender();
  StartPlaying.setupRender();
  Play.setupRender();
  Options.setupRender();
  Exit.setupRender();
  Back.setupRender();
  Scores.setupRender();
  
  menu.addObject(menusBG);
  menu.addObject(Play);
  menu.addObject(Options);
  menu.addObject(Exit);
  menu.addObject(Scores);
  options.addObject(menusBG);
  options.addObject(Back);
  play.addObject(Pause);
  play.addObject(BackToMenu);
  play.addObject(StartPlaying);
  play.addObject(circle);
  
  windows.add(0, menu);
  windows.add(1, options);
  windows.add(2, play);
  windows.add(3, scores);
  
  Thread t=new Thread(new Runnable(){
    public void run()
    {
      while(true)
      {
        windows.get(currentWindow).listen();
  
        if(showScores)
          windows.get(3).listen();
        //println("kk");
      }
    }
  });
  t.start();
}

void draw()
{
  loopTime= System.currentTimeMillis()-runTime-startTime;
  runTime= System.currentTimeMillis()-startTime;
  //overallLoopTime=runTime/frameCount; 
  //println(frameRate);
  
  background(25);
  
  windows.get(currentWindow).display();
  
  if(showScores)
  {
    image(scoresBG,225,25);
    windows.get(3).display();
  }
  
  textSize(10);
  fill(255);
  text(frameRate,50,50);
}