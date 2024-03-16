function [S_mip, S_traj] = NeedleTrackig(img,params);

img=img./max(img(:));
[ny,nx,nt]=size(img);
T_period=params.T_period;
M = reshape(img,[ny*nx,nt]);

nn=1;
for t=1:T_period:nt
    if (t+2*T_period)< nt
        M1=M(:,1:t+T_period-1);
        [P,S,V]=svd(M1,0);
        P = P(:,1:2);

        M2=M(:,t+T_period:t-1+2*T_period); rk=1;
        y_traj=M2-P*(P'*M2); S_traj = M2-mean(M2,2);
        S_traj_old=S_traj;

        for n=1:30
            G=S_traj+1.0.*(y_traj - S_traj-P*(P'*S_traj)) - 0.8.*(P*(P'*(y_traj - S_traj-P*(P'*S_traj))));
            [u,s,v]=svd(G,0);
            S_traj=u(:,1:rk)*s(1:rk,1:rk)*v(:,1:rk)';
            err = sum(sum(S_traj-S_traj_old));
            if (err < 0.001) && (n>10)
                break;
            end
            S_traj_old = S_traj;
        end
        T_toc{5}(nn)=toc;

        S_traj=reshape(S_traj,[ny,nx,size(M2,2)]);
        S_mip(:,:,nn) = max(S_traj,[],3);
        nn=nn+1;
    end

end


end