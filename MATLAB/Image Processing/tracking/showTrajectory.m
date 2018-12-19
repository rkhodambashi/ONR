function  showTrajectory(fig,position,RECT)
    fig;hold on;
    if (isempty(RECT))
        plot(position(1,:),-position(2,:),'b.');
    else
        position(1,:) = position(1,:)+RECT(1);
        position(2,:) = position(2,:)+RECT(2);
        plot(position(1,:),position(2),'b.');
    end
end