% this matlab program plots the electric field lines and voltage for
% equipotentrial surfaces . The case is a square coaxial cable, with inner
% voltgae asked by the user. the outer cable is grounded so 0 volts. The
% plots very clearly depicts how the e fild is perpendicular to the
% equipotential surfaces. 
%_______________________
% Debi Prasad Pattnaik, University of Nottingham. WWW.debipatnaik.com
V = inputdlg('Voltage of inner cable');
VIn=str2num(V{1,1});
VOut=0;%voltage on outer conductor  
%VIn=input('Voltage of inner conductor: ');
nx=20; %number of points in the x axis
ny=nx; %number of points in the y axis
npoints=nx*ny;
A=zeros(npoints,npoints); %this is the matrix of coefficients 
AB=zeros(npoints,1);%solution matrix
jwest=(nx+1)/3;% points in the west neighbourhood
jeast=2*jwest;%points in the east neighbourhood
isouth=(ny+1)/3;%points in the south neighbourhood
inorth=2*isouth;%points in the north neighbourhood
counter=1; %this is the counter of the equations for sclar multiplication
for i=1:nx  %repeat for all rows 
  for j=1:ny %repeat for all columns 
      if((i>=isouth&i<=inorth)&(j>=jwest&j<=jeast))%i am inside the conductor now
          A(counter, counter)=1; 
          AB(counter,1)=VIn; 
      else 
          A(counter, counter)=-4; 
          if(j==1) % this is the first column 
            AB(counter, 1)=AB(counter,1)-VOut; % left point is on  boundary 
          else%store the coefficient of the left point 
             A(counter,counter-1)=1.0;  
          end 
          if(j==ny) % this is the last column 
             AB(counter, 1)= AB(counter,1)-VOut;%on right boundary 
          else %store coefficient of right boundary 
             A(counter, counter+1)=1.0; 
          end 
          if(i==1) % this is the first row 
             AB(counter,1)=AB(counter,1)-VOut; %top point is on boundary 
          else %store coefficient of top point 
             A(counter, counter-nx)=1; 
          end 
          if(i==nx) % this is the last row 
             AB(counter,1)=AB(counter,1)-VOut; %bottom point is on boundary 
          else%store coefficient of bottom point 
  
                                                   
               A(counter, counter+nx)=1.0;  
          end 
      end 
       counter=counter+1; 
  end 
end
V=A\AB; %obtain the vector of voltages  
V_Square=reshape(V, nx, ny);%convert values into a rectangular matrix 
surf(V_Square); %obtain the surface figure 
figure; 
[C,h] = contour(V_Square);% obtain the contour figure 
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2) 
colormap cool; 
figure; 
contour(V_Square); 
[ex,ey] = gradient(V_Square); 
hold on,
quiver(-ex,-ey,1.5,'k');
 hold off
%obtain the electric field map by using E=-Gradient(V