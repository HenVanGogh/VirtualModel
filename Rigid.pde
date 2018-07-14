class rigidBody{
  PVector location , rotation , gravity;
  Overlord mech1 = new Overlord(100);
  
  void updateGravityCenter(){
     gravity = mech1.getGravity();
  }
  
  rigidBody(){
  }
  void applyGravity(){
    float[] floorPoints = {
    mech1.Leg1.drawPos[4][2] ,
    mech1.Leg2.drawPos[4][2] ,
    mech1.Leg3.drawPos[4][2] ,
    mech1.Leg4.drawPos[4][2] };
    
    float[][] floorTouch = {
      { mech1.Leg1.drawPos[4][1] , mech1.Leg1.drawPos[4][3] } ,
      { mech1.Leg2.drawPos[4][1] , mech1.Leg2.drawPos[4][3] } ,
      { mech1.Leg3.drawPos[4][1] , mech1.Leg3.drawPos[4][3] } ,
      { mech1.Leg4.drawPos[4][1] , mech1.Leg4.drawPos[4][3] } };
    
    
    boolean[] isTouching = new boolean[3];
    
    float minimum = min(floorPoints);
    
    int count = 0;
    
    for(int r = 0; r < 4; r++){
    if(floorPoints[r] == minimum){
      count++; 
      isTouching[r] = true;
    }else{
      isTouching[r] = false; 
    }
    }
    
    
    if(count == 2){
        float[][] groundPoints;
      //int n = 0;
      int t = 0;
      for(int n = 0 ; n < 2;n++){
      if(isTouching[n]){
        groundPoints[t][0] = floorTouch[n][0];
        groundPoints[t][1] = floorTouch[n][1];
        t++;
      }
      
      
      }
      
    }else if(count == 3){
      float[][] groundPoints;
      //int n = 0;
      int t = 0;
      for(int n = 0 ; n < 3;n++){
      if(isTouching[n]){
        groundPoints[t][0] = floorTouch[n][0];
        groundPoints[t][1] = floorTouch[n][1];
        t++;
      }
      if(isInsideTriangle(groundPoints[0][0] , groundPoints[0][1] ,
                       groundPoints[1][0] , groundPoints[1][1] ,
                       groundPoints[2][0] , groundPoints[2][1] ,
                       gravity.x , gravity.z)){
                         return;
                       }else{
                         
                       }
      
      }
      
    }else if(count == 4){
        float[][] groundPoints;
      //int n = 0;
      int t = 0;
      for(int n = 0 ; n < 4;n++){
      if(isTouching[n]){
        groundPoints[t][0] = floorTouch[n][0];
        groundPoints[t][1] = floorTouch[n][1];
        t++;
      }
      if(isInsideSquare(groundPoints[0][0] , groundPoints[0][1] ,
                       groundPoints[1][0] , groundPoints[1][1] ,
                       groundPoints[2][0] , groundPoints[2][1] ,
                       groundPoints[3][0] , groundPoints[3][1] ,
                       gravity.x , gravity.z)){
                         return;
                       }else{
                         
                       }
      }
      
    }else if(count == 1){
        float[][] groundPoints;
      //int n = 0;
      int t = 0;
      for(int n = 0 ; n < 1;n++){
      if(isTouching[n]){
        groundPoints[t][0] = floorTouch[n][0];
        groundPoints[t][1] = floorTouch[n][1];
        t++;
      }
      }
    }
    
  }
  
  
    void update(){
  mech1.setPoint(location.x , location.y  , location.z );
  mech1.setRotation(rotation.x, rotation.y, rotation.z);
  
  mech1.setEndPoint1(200 , 0 , 200);
  mech1.setEndPoint2(-200 , 0 , 200);
  mech1.setEndPoint3(-200 , 0 , -200);
  mech1.setEndPoint4(200 , 0 , -200);
  
  mech1.update();
  gravity = mech1.getGravity();
  
    }
    
    void
  }
  
  
  
  
  
  
  
  
  
  
  
 