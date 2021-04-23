final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

float soldierX, soldierY, soldierXSpeed, cabbageX, cabbageY, groundhogX, groundhogY;

boolean cabbageAppear = true;

int down = 0;
int right = 0;
int left = 0;
int actionFrame = 15;
final int BLOCK_WIDTH = 80;
int downMoveY = 0;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage bg, life, soil8x24, stone1, stone2, soldier, cabbage;
PImage soil0, soil1, soil2, soil3, soil4, soil5;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
  frameRate(60);
  
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
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  
  // Soldier
  soldierX = -80;
  soldierY = floor(random(2,6))*80;
  soldierXSpeed = 4;
  
  // Cabbage
  cabbageX = floor(random(8))*80;
  cabbageY = floor(random(2,6))*80;
  
  
  // Groundhog
  groundhogX = 320;
  groundhogY = 80;
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
		rect(0, 160 - GRASS_HEIGHT - downMoveY, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		//image(soil8x24, 0, 160);

    // soil0 & soil1
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<320; y+= BLOCK_WIDTH){
        image(soil0, x, y+160-downMoveY);
        image(soil1, x, y+480-downMoveY);
        image(stone1, x, x+160-downMoveY);
      }
    }
    
    // soil2 & soil3
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<320; y+= BLOCK_WIDTH){
        image(soil2, x, y+800-downMoveY);
        image(soil3, x, y+1120-downMoveY);
      }
    }
    
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<640; y+= BLOCK_WIDTH){
        if( y % (4*BLOCK_WIDTH) == 0 || y% (4*BLOCK_WIDTH) == 3*BLOCK_WIDTH){
          if( x % (4*BLOCK_WIDTH) == 1*BLOCK_WIDTH || x % (4*BLOCK_WIDTH) == 2*BLOCK_WIDTH){
            image(stone1, x, y+800-downMoveY);
          }
        }
        if( y % (4*BLOCK_WIDTH) == 1*BLOCK_WIDTH || y% (4*BLOCK_WIDTH) == 2*BLOCK_WIDTH){
          if( x % (4*BLOCK_WIDTH) == 0 || x % (4*BLOCK_WIDTH) == 3*BLOCK_WIDTH){
            image(stone1, x, y+800-downMoveY);
          }
        }
      }
    }
    
    // soil4 & soil5
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<320; y+= BLOCK_WIDTH){
        image(soil4, x, y+1440-downMoveY);
        image(soil5, x, y+1760-downMoveY);
      }
    }
    
    for(int x=0; x<640; x+= BLOCK_WIDTH){
      for(int y=0; y<640; y+= BLOCK_WIDTH){
        if( y % (3*BLOCK_WIDTH) == 0){
          if( x % (3*BLOCK_WIDTH) != 0){
            image(stone1, x, y+1440-downMoveY);
            if( x % (3*BLOCK_WIDTH) == 2*BLOCK_WIDTH){
              image(stone2, x, y+1440-downMoveY);
            }
          }
        }
        if( y % (3*BLOCK_WIDTH) == 1*BLOCK_WIDTH){
          if( x % (3*BLOCK_WIDTH) != 2*BLOCK_WIDTH){
            image(stone1, x, y+1440-downMoveY);
            if( x % (3*BLOCK_WIDTH) == 1*BLOCK_WIDTH){
              image(stone2, x, y+1440-downMoveY);
            }
          }
        }
        if( y % (3*BLOCK_WIDTH) == 2*BLOCK_WIDTH){
          if( x % (3*BLOCK_WIDTH) != 1*BLOCK_WIDTH){
            image(stone1, x, y+1440-downMoveY);
            if( x % (3*BLOCK_WIDTH) == 0){
              image(stone2, x, y+1440-downMoveY);
            }
          }
        }
      }
    }
    
    // Groundhog movement
    // DOWN
    if(downMoveY < BLOCK_WIDTH*20){
      if(down > 0){
        if(down == 1){
          downMoveY = round(downMoveY + BLOCK_WIDTH/actionFrame);
          image(groundhogIdle, groundhogX, groundhogY);
        }else{
          downMoveY = downMoveY + BLOCK_WIDTH/actionFrame;
          image(groundhogDown, groundhogX, groundhogY);
        }
        down -= 1;
      }
    }
    
    if(downMoveY >= BLOCK_WIDTH*20){
      downMoveY = BLOCK_WIDTH*20;
      if(down > 0){
        if(down == 1){
          groundhogY = round(groundhogY + BLOCK_WIDTH/actionFrame);
          image(groundhogIdle, groundhogX, groundhogY);
        }else{
          groundhogY = groundhogY + BLOCK_WIDTH/actionFrame;
          image(groundhogDown, groundhogX, groundhogY);
        }
        down -= 1;
      }
    }
      
    // LEFT
    if(left > 0){
      if(left == 1){
        groundhogX = round(groundhogX - BLOCK_WIDTH/actionFrame);
        image(groundhogIdle, groundhogX, groundhogY);
      }else{
        groundhogX = groundhogX - BLOCK_WIDTH/actionFrame;
        image(groundhogLeft, groundhogX, groundhogY);
      }
      left -= 1;
    }
      
    // RIGHT
    if(right > 0){
      if(right == 1){
        groundhogX = round(groundhogX + BLOCK_WIDTH/actionFrame);
        image(groundhogIdle, groundhogX, groundhogY);
      }else{
        groundhogX = groundhogX + BLOCK_WIDTH/actionFrame;
        image(groundhogRight, groundhogX, groundhogY);
      }
      right -= 1;
    }
      
    // NO MOVE
    if(down == 0 && left == 0 && right == 0){
      image(groundhogIdle, groundhogX, groundhogY);
    }
    
    //println(groundhogX, groundhogY);
    
    // Soldier
    // soldier random appear
    image(soldier, soldierX, soldierY - downMoveY);
      
    // soldier left to right
    soldierX += soldierXSpeed;
    if(soldierX >= 640) soldierX = -80;
    
    // Groundhog bump into soldier
      if(groundhogX < soldierX + 80 && groundhogX + 80 > soldierX){
        if(groundhogY < soldierY + 80 - downMoveY && groundhogY + 80 > soldierY - downMoveY){
          playerHealth --;
          groundhogX = 320;
          groundhogY = 80;
          downMoveY = 0;
        }
      }
    //println(downMoveY);
    
    // Groundhog eat cabbage
      if(groundhogX < cabbageX + 80 && groundhogX + 80 > cabbageX){
        if(groundhogY < cabbageY + 80 - downMoveY && groundhogY + 80 > cabbageY - downMoveY){
          playerHealth ++;
          cabbageAppear = false;
        }
      }
      
      // Cabbage
      if(cabbageAppear == true){
        image(cabbage, cabbageX, cabbageY - downMoveY);
      }
      if(cabbageAppear == false){
        cabbageX = -80;
        cabbageY = -80;
        image(cabbage, cabbageX, cabbageY - downMoveY);
      }
      

		// Player

		// Health UI
    for(int i=0; i < playerHealth; i++){
      image(life, 10 + 70*i, 10);
    }
    
    if( playerHealth == 0){
      gameState = GAME_OVER;
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
        // Soldier
        soldierX = -80;
        soldierY = floor(random(2,6))*80;
        soldierXSpeed = 4;
  
        // Cabbage
        cabbageX = floor(random(8))*80;
        cabbageY = floor(random(2,6))*80;
        cabbageAppear = true;
  
        // Groundhog
        groundhogX = 320;
        groundhogY = 80;
        
        // Health UI
        playerHealth = 2;
        
        // Down move reset
        downMoveY = 0;
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
  // Groundhog Move Lock
  if(down > 0 || left > 0 || right > 0){
    return;
  }
  
  if (key == CODED){
    switch(keyCode){
      case DOWN:
        if(groundhogY < 400){
          downPressed = true;
          down = 15;
        }
        break;
      case LEFT:
        if(groundhogX > 0){
          leftPressed = true;
          left = 15;
        }
        break;
      case RIGHT:
        if(groundhogX < 560){
          rightPressed = true;
          right = 15;
        }
        break;
    }
  }
  
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
  if (key == CODED){
    switch(keyCode){
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed= false;
        break;
    }
  }
}
