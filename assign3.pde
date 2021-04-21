final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int LIFE_ONE = 1;
final int LIFE_TWO = 2;
final int LIFE_THREE = 3;
int gameLife = LIFE_TWO;

int down = 0;
int right = 0;
int left = 0;
int actionFrame = 15;
final int BLOCK_WIDTH = 80;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage bg, life, soil8x24, stone1, stone2;
PImage soil0, soil1, soil2, soil3, soil4, soil5;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  life = loadImage("img/life.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	  stroke(255,255,0);
	  strokeWeight(5);
	  fill(253,184,19);
	  ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		//image(soil8x24, 0, 160);

    // soil0 & soil1
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<320; y+= BLOCK_WIDTH){
        image(soil0, x, y+160);
        image(soil1, x, y+480);
        image(stone1, x, x+160);
      }
    }
    
    // soil2 & soil3
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<320; y+= BLOCK_WIDTH){
        image(soil2, x, y+800);
        image(soil3, x, y+1120);
      }
    }
    
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<640; y+= BLOCK_WIDTH){
        if( y % (4*BLOCK_WIDTH) == 0 || y% (4*BLOCK_WIDTH) == 3*BLOCK_WIDTH){
          if( x % (4*BLOCK_WIDTH) == 1*BLOCK_WIDTH || x % (4*BLOCK_WIDTH) == 2*BLOCK_WIDTH){
            image(stone1, x, y+800);
          }
        }
        if( y % (4*BLOCK_WIDTH) == 1*BLOCK_WIDTH || y% (4*BLOCK_WIDTH) == 2*BLOCK_WIDTH){
          if( x % (4*BLOCK_WIDTH) == 0 || x % (4*BLOCK_WIDTH) == 3*BLOCK_WIDTH){
            image(stone1, x, y+800);
          }
        }
      }
    }
    
    // soil4 & soil5
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<320; y+= BLOCK_WIDTH){
        image(soil4, x, y+1440);
        image(soil5, x, y+1760);
      }
    }
    
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<640; y+= BLOCK_WIDTH){
        if( y % (3*BLOCK_WIDTH) == 0){
          if( x % (3*BLOCK_WIDTH) != 0){
            image(stone1, x, y+1440);
            if( x % (3*BLOCK_WIDTH) == 2*BLOCK_WIDTH){
              image(stone2, x, y+1440);
            }
          }
        }
        if( y % (3*BLOCK_WIDTH) == 1*BLOCK_WIDTH){
          if( x % (3*BLOCK_WIDTH) != 2*BLOCK_WIDTH){
            image(stone1, x, y+1440);
            if( x % (3*BLOCK_WIDTH) == 1*BLOCK_WIDTH){
              image(stone2, x, y+1440);
            }
          }
        }
        if( y % (3*BLOCK_WIDTH) == 2*BLOCK_WIDTH){
          if( x % (3*BLOCK_WIDTH) != 1*BLOCK_WIDTH){
            image(stone1, x, y+1440);
            if( x % (3*BLOCK_WIDTH) == 0){
              image(stone2, x, y+1440);
            }
          }
        }
      }
    }

		// Player

		// Health UI
    switch(gameLife)
    {
      case LIFE_ONE:
      //background(bg);
      image(life, 10, 10);
      break;
      
      case LIFE_TWO:
      //background(bg);
      image(life, 10, 10);
      image(life, 80, 10);
      break;
      
      case LIFE_THREE:
      //background(bg);
      image(life, 10, 10);
      image(life, 80, 10);
      image(life, 150, 10);
      break;
    }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
