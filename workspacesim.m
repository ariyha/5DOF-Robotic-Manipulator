q1 = linspace(0,2000,100);
q2 = linspace(-0.92,0.92,50);
q3 = linspace(0,500,50);

end_effector_positions=[];
for i=1:length(q1)
    for j=1:length(q2)
        for k=1:length(q3)
                    T_current = R.fkine([q1(i) q2(j) q3(k) 0 0 0]);
                    end_effector_positions= [end_effector_positions,T_current.t];
        end
    end
end

%%
C = end_effector_positions(3,:);

% Plot end effector positions with gradient
close all;
figure;
scatter3(end_effector_positions(1,:), end_effector_positions(2,:), end_effector_positions(3,:), 20, C, 'filled');  % Adjust marker size and colormap
colormap('summer');  % Choose a colormap, e.g., 'jet', 'parula', 'hsv'
colorbar;  % Show colorbar
grid on;
title('End Effector Positions');
xlabel('X');
ylabel('Y');
zlabel('Z');
