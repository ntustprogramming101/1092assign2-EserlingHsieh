PImage bg;
PImage groundhog;
PImage life;
PImage soil;
PImage soldier;

PImage cabbage;
PImage gameover;
PImage groundhogDown;
PImage groundhogIdle;
PImage groundhogLeft;
PImage groundhogRight;
PImage restartHovered;
PImage restartNormal;
PImage startHovered;
PImage startNormal;
PImage title;

int soldierLevel;
float soldierX;
float soldierSpeed = 640.0 / 120;

float groundhogSpeed = 1;
float groundhogX; 
float groundhogY;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

int cabbageX;
int cabbageY;
int a=0;
int b=0;
int c=0;

int hp=2;

void setup() {
    size(640, 480, P2D);
    bg = loadImage("img/bg.jpg");
    life = loadImage("img/life.png");
    soil = loadImage("img/soil.png");
    soldier = loadImage("img/soldier.png");
    cabbage = loadImage("img/cabbage.png");
    gameover = loadImage("img/gameover.jpg");
    groundhogDown = loadImage("img/groundhogDown.png");
    groundhogIdle = loadImage("img/groundhogIdle.png");
    groundhogLeft = loadImage("img/groundhogLeft.png");
    groundhogRight = loadImage("img/groundhogRight.png");
    restartHovered = loadImage("img/restartHovered.png");
    restartNormal = loadImage("img/restartNormal.png");
    startHovered = loadImage("img/startHovered.png");
    startNormal = loadImage("img/startNormal.png");
    title = loadImage("img/title.jpg");
    
    //soldier appear
    soldierLevel = floor(random(2,6)) * 80;
    soldierX = - 80;
    
    groundhogX = 320;
    groundhogY = 80;
    
    cabbageX = floor(random(0,8)) * 80;
    cabbageY = floor(random(2,6)) * 80;
    
}

void draw() {
    switch(gameState) {
        case GAME_START:
        if (mouseX > 248 && mouseX < 248 + 144
            && mouseY > 360 && mouseY < 360 + 60) {
            image(startHovered, 248, 360);        
            if (mousePressed) {
                gameState = GAME_RUN;} }
        
        else{
            image(title, 0, 0);
            image(startNormal, 248, 360);}
        
        break;
        
        case GAME_RUN:
        
        //background setup
        image(bg,0,0);
        image(soil,0,160);

        
        //draw ground
        noStroke();
        fill(124,204,25);
        rect(0,145,640,15);
        
        //draw sun
        fill(253,184,19);
        stroke(255,255,0);
        strokeWeight(5);
        ellipse(590,50,120,120);
        
        
        
        
        //start to move
        if (a > 0) {
            //last step
            if (a == 1) { //<>//
                groundhogX = groundhogX + 80;
                image(groundhogIdle,groundhogX,groundhogY);
                groundhogSpeed = 1;
            }
            else{
                image(groundhogRight,groundhogX + 80.0 / 15 * groundhogSpeed,groundhogY);
                groundhogSpeed +=1;
            }
            a -=1;
        }
        
        
        if (b > 0) {
            //last step
            if (b == 1) {
                groundhogX = groundhogX - 80;
                image(groundhogIdle,groundhogX,groundhogY);
                groundhogSpeed = 1;
            }
            else{
                image(groundhogLeft,groundhogX - 80.0 / 15 * groundhogSpeed,groundhogY);
                groundhogSpeed +=1;
            }
            b -=1;
        }

        
        if (c > 0) {
            //last step
            if (c == 1) {
                groundhogY = groundhogY + 80;
                image(groundhogIdle,groundhogX,groundhogY);
                groundhogSpeed = 1;
            }
            else{
                image(groundhogDown,groundhogX,groundhogY + 80.0 / 15 * groundhogSpeed);
                groundhogSpeed +=1;
            }
            c -=1;
        }
        
        //no move
        if (a == 0 && b == 0 && c == 0 ) 
        {image(groundhogIdle,groundhogX,groundhogY);}
        
        
        
        //soldier bump detect
        if (groundhogX > soldierX % 720 - 80 && groundhogX < soldierX % 720 + 80
            && groundhogY > soldierLevel - 80 && groundhogY < soldierLevel + 80) {
            groundhogX = 320;
            groundhogY = 80;
            hp-=1;
            a = 0;
            b = 0;
            c = 0;
            if(hp==0){
              gameState=GAME_OVER;
            }
          }
       
        
        //soldier walk
        soldierX = (soldierX + soldierSpeed);
        image(soldier,soldierX % 720,soldierLevel); 
        
        //cabbage
        image(cabbage,cabbageX,cabbageY);
        if (groundhogX == cabbageX && groundhogY == cabbageY) {
            cabbageX = 0;
            cabbageY =- 80;
            hp+=1;
        }
        
        //life
        image(life,10-210+70*hp,10);
        image(life,10-140+70*hp,10);
        image(life,10-70+70*hp,10);//hp=1,2,3

        break;
        
        case GAME_OVER:
        if (mouseX > 248 && mouseX < 248 + 144
            && mouseY > 360 && mouseY < 360 + 60) {
            image(gameover, 0, 0);
            image(restartHovered, 248, 360);        
            if (mousePressed) {
                gameState = GAME_RUN;
                hp=2;
                soldierLevel = floor(random(2,6)) * 80;
                soldierX = - 80;
                cabbageX = floor(random(0,8)) * 80;
                cabbageY = floor(random(2,6)) * 80;
                a = 0;
                b = 0;
                c = 0;
                } 
                }
        
        else{
            image(gameover, 0, 0);
            image(restartNormal, 248, 360);}
        break;
        
    }
}
void keyPressed() {
    if (a > 0 || b > 0 || c > 0) {
        return;
    }
    switch(keyCode) {
        case RIGHT:
        if (groundhogX < 560) {a = 15;}
        break;
        
        case LEFT:
        if (groundhogX > 0) {b = 15;}
        break;
        
        case DOWN:
        if (groundhogY < 400) {c = 15;}
        break;
    } 
}
