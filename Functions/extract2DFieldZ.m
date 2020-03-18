function E2d=extract2DFieldZ(E,flag,cplane)

if flag==1
      for i=1:length(E.x)
          if cplane==E.x(i)  
          E2d.x=E.y;E2d.y=E.z;E2d.z=cplane;    
          E2d.Ex=squeeze(E.Ey(i,:,:));
          E2d.Ey=squeeze(E.Ez(i,:,:));
          E2d.Ez=squeeze(E.Ex(i,:,:));
          E2d.Mod=sqrt(E2d.Ex.^2+E2d.Ey.^2+E2d.Ez.^2);
                    break;

          end  
      end    
elseif flag==2
       for i=1:length(E.y)
          if cplane==E.y(i)  
          E2d.x=E.x;E2d.y=E.z;E2d.z=cplane;    
          E2d.Ex=squeeze(E.Ez(:,i,:));
          E2d.Ey=squeeze(E.Ex(:,i,:));
          E2d.Ez=squeeze(E.Ey(:,i,:));
          E2d.Mod=sqrt(E2d.Ex.^2+E2d.Ey.^2+E2d.Ez.^2);
           break;
          end  
       end      
else 
       for i=1:length(E.z)
          if cplane*1000==1000*E.z(i)  
          E2d.x=E.x;E2d.y=E.y;E2d.z=cplane;    
          E2d.Ex=squeeze(E.Ex(:,:,i));
          E2d.Ey=squeeze(E.Ey(:,:,i));
          E2d.Ez=squeeze(E.Ez(:,:,i));
          E2d.Mod=sqrt(E2d.Ex.^2+E2d.Ey.^2+E2d.Ez.^2);     
          break;
          end  
       end         
end