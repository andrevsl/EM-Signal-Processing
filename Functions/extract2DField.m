function E2d=extract2DField(E,flag,cplane)

if flag==1
      for i=1:length(E.x)
          if cplane==E.x(i)  
          E2d.x=cplane;E2d.y=E.y;E2d.z=E.z;    
          E2d.Ex=squeeze(E.Ex(i,:,:));
          E2d.Ey=squeeze(E.Ey(i,:,:));
          E2d.Ez=squeeze(E.Ez(i,:,:));
          end  
      end    
elseif flag==2
       for i=1:length(E.y)
          if cplane==E.y(i)  
          E2d.x=E.x;E2d.y=cplane;E2d.z=E.z;    
          E2d.Ex=squeeze(E.Ex(:,i,:));
          E2d.Ey=squeeze(E.Ey(:,i,:));
          E2d.Ez=squeeze(E.Ez(:,i,:));
          end  
       end      
else 
       for i=1:length(E.z)
          if cplane==E.z(i)  
          E2d.x=E.x;E2d.y=E.y;E2d.z=cplane;    
          E2d.Ex=squeeze(E.Ex(:,:,i));
          E2d.Ey=squeeze(E.Ey(:,:,i));
          E2d.Ez=squeeze(E.Ez(:,:,i));
          end  
       end         
end