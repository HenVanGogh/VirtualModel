float area(float x1, float y1, float x2, float y2, float x3, float y3)
{
   return abs((x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2))/2.0);
}
 
/* A function to check whether pofloat P(x, y) lies inside the triangle formed 
   by A(x1, y1), B(x2, y2) and C(x3, y3) */
boolean isInsideTriangle(float x1, float y1, float x2, float y2, float x3, float y3, float x, float y)
{   
   /* Calculate area of triangle ABC */
   float A = area (x1, y1, x2, y2, x3, y3);
 
   /* Calculate area of triangle PBC */  
   float A1 = area (x, y, x2, y2, x3, y3);
 
   /* Calculate area of triangle PAC */  
   float A2 = area (x1, y1, x, y, x3, y3);
 
   /* Calculate area of triangle PAB */   
   float A3 = area (x1, y1, x2, y2, x, y);
   
   /* Check if sum of A1, A2 and A3 is same as A */
   return (A == A1 + A2 + A3);
}

boolean isInsideSquare(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4 , float x, float y){
 if(int(isInsideTriangle( x1,  y1,  x2,  y2,  x3,  y3,  x,  y))
 + int(isInsideTriangle( x1,  y1,  x4,  y4,  x3,  y3,  x,  y)) != 0) return true; 
 return false;
}


boolean isInsideSquare(PVector A , PVector B , PVector C , PVector D , PVector O){
 if(int(isInsideTriangle(A.x , A.y , B.x , B.y , C.x , C.y , O.x , O.y))
 + int(isInsideTriangle(A.x , A.y , D.x , D.y , C.x , C.y , O.x , O.y)) != 0) return true; 
 return false;
}



PVector lineFromPoints(PVector P, PVector Q)
{
    float a = Q.y - P.y;
    float b = P.x - Q.x;
    float c = a*(P.x) + b*(P.y);
    
    return new PVector(a , b, c);
}

boolean isAboveLine(PVector line , PVector point){
  float y = (line.z - (line.x * point.x)) / line.y;
  if(point.y > y){
   return true;
  }else{
    return false;
  }
}

int orientation(PVector p, PVector q, PVector r)
{
    // See https://www.geeksforgeeks.org/orientation-3-ordered-points/
    // for details of below formula.
    float val = (q.y - p.y) * (r.x - q.x) -
              (q.x - p.x) * (r.y - q.y);
 
    if (val == 0) return 0;  // colinear
 
    return (val > 0)? 1: 2; // clock or counterclock wise
}

boolean onSegment(PVector p, PVector q, PVector r)
{
    if (q.x <= max(p.x, r.x) && q.x >= min(p.x, r.x) &&
        q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y))
       return true;
 
    return false;
}

boolean doIntersect(PVector p1, PVector q1, PVector p2, PVector q2)
{
    // Find the four orientations needed for general and
    // special cases
    float o1 = orientation(p1, q1, p2);
    if(o1 == 0) return false;
    float o2 = orientation(p1, q1, q2);
    if(o2 == 0) return false;
    float o3 = orientation(p2, q2, p1);
    if(o3 == 0) return false;
    float o4 = orientation(p2, q2, q1);
    if(o4 == 0) return false;
 
    // General case
    if (o1 != o2 && o3 != o4)
        return true;
 
    // Special Cases
    // p1, q1 and p2 are colinear and p2 lies on segment p1q1
    if (o1 == 0 && onSegment(p1, p2, q1)) return true;
 
    // p1, q1 and q2 are colinear and q2 lies on segment p1q1
    if (o2 == 0 && onSegment(p1, q2, q1)) return true;
 
    // p2, q2 and p1 are colinear and p1 lies on segment p2q2
    if (o3 == 0 && onSegment(p2, p1, q2)) return true;
 
     // p2, q2 and q1 are colinear and q1 lies on segment p2q2
    if (o4 == 0 && onSegment(p2, q1, q2)) return true;
 
    return false; // Doesn't fall in any of the above cases
}

PVector convertLinear(PVector A){
  A.x = A.x / A.y;
  A.z = A.z / A.y;
  return new PVector(A.x , A.z);
}

PVector convertAngular(PVector A){
  A.x = -1 / A.x;
  return new PVector(A.x , A.y , A.z);
}


  PVector getRotationAxis(PVector P1 , PVector P2 , PVector P3 , PVector C ){ 
  PVector eq1 , eq2 , eq3;
  
  eq1 = lineFromPoints(P1 , P2);
  eq2 = lineFromPoints(P2 , P3);
  eq3 = lineFromPoints(P3 , P1);
  
  int countP;
  
  countP = int(isAboveLine(eq1 , C)) + int(isAboveLine(eq2 , C)) + int(isAboveLine(eq3 , C));
  if((countP == 1) && (countP == 3)){
    if(doIntersect( C , P1 , P2 , P3)) return eq2;
    if(doIntersect( C , P2 , P1 , P3)) return eq3;
    if(doIntersect( C , P3 , P2 , P1)) return eq1;
  }else{
    if(!doIntersect( C , P1 , P2 , P3)){
      PVector argu = lineFromPoints(C , P1);
      argu = convertLinear(argu);
      
      float D1 = distanceFromLine(argu , P2);
      float D2 = distanceFromLine(argu , P3);
      if(D1 > D2){
        return eq3;
      }else if(D2 > D1){
        return eq1;
      }else{
      //Then you are lost ALso how are the odds???
      }
    } else if(!doIntersect( C , P2 , P1 , P3)){
      PVector argu = lineFromPoints(C , P2);
      argu = convertLinear(argu);
      
      float D1 = distanceFromLine(argu , P1);
      float D2 = distanceFromLine(argu , P3);
      if(D1 > D2){
        return eq2;
      }else if(D2 > D1){
        return eq1;
      }else{
      //Then you are lost ALso how are the odds???
      }
      
    }else if(!doIntersect( C , P3 , P2 , P1)){
      PVector argu = lineFromPoints(C , P3);
      argu = convertLinear(argu);
      
      float D1 = distanceFromLine(argu , P2);
      float D2 = distanceFromLine(argu , P3);
      if(D1 > D2){
        return eq3;
      }else if(D2 > D1){
        return eq2;
      }else{
      //Then you are lost ALso how are the odds???
      }
      
    }
  }
  return new PVector(-1 , -1 , -1);
  }
  
  float distanceFromLine(PVector line , PVector point){
    return (point.x - (line.x * point.x + line.y)) * cos(1.5708 - (sin(point.y / hypot(point.x , point.y))));
  }
  