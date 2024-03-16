function est_traj(Needles,frame,range);

a=Needles(:,:,frame);
thres=0.2;
a(find(a<thres))=0;
a(find(a>=thres))=1;

[H,T,R] = hough(a,'Theta',range);

P  = houghpeaks(H,1);
x = T(P(:,2)); y = R(P(:,1));

lines = houghlines(a,T,R,P,'FillGap',50,'MinLength',7);
% figure, imshow(img(:,:,172)), hold on
figure, imshow(a), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','yellow');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','blue');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end