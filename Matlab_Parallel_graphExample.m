gridSize = 6;
mu = linspace(100, 150, gridSize);
nu = linspace(0.5, 2, gridSize);
[M,N] = meshgrid(mu,nu);

Z = nan(size(N));
c = surf(M, N, Z);
xlabel('\mu Values','Interpreter','Tex')
ylabel('\nu Values','Interpreter','Tex')
zlabel('Mean Period of  y')
view(137, 30)
axis([100 150 0.5 2 0 500]);

D = parallel.pool.DataQueue;
D.afterEach(@(x) updateSurface(c, x));

parfor ii = 1:numel(N)
    [t, y] = solveVdp(M(ii), N(ii));
    l = islocalmax(y(:, 2));
    send(D, [ii mean(diff(t(l)))]);
end


gridSize = 25;
delete(gcp('nocreate'));
parpool('local',2);

function [t, y] = solveVdp(mu, nu)
f = @(~,y) [nu*y(2); mu*(1-y(1)^2)*y(2)-y(1)];
[t,y] = ode23s(f,[0 20*mu],[2; 0]);
end

function updateSurface(s, d)
s.ZData(d(1)) = d(2);
drawnow('limitrate');
end