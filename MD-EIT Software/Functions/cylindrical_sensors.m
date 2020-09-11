function sensors = cylindrical_sensors(distances,heights, points_on_circle)
theta = linspace(0,2*pi,21); theta(end) = [];
for k = 1:distances
    for j = 1:heights
        for i = 1:points_on_circle
            sensors(-220 + 20*j +200*k + i,:) = [(0.0005+0.0001*k)*cos(theta(i)), (0.0005 + 0.0001*k)*sin(theta(i)), -0.06 + j*0.01];
        end
    end
end

end

