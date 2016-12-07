function [u, diff_u,func]=LinearDiffusion2016f(fn, lambda, dt, Nit);
% Emanuele Schiavi curso 2016-2017
% Algoritmo para difusion lineal
% Devuelve valores del funcional de energia
[m, n]=size(fn);
% paso de discretizacion espacial
hx=1;
hy=1;
% Inicializacion: imagen contaminada
u=fn;
func=zeros(1,Nit);

for k=1:Nit
    % Almaceno la solucion en la iterada previa
    u_prev=u;
    % Calculo derivadas
    % esta discretizacion asegura conservacion de la masa
    u_xmas=[u(:,2:end)-u(:,1:end-1), zeros(m,1)]/hx;
    u_ymas=[u(2:end,:)-u(1:end-1,:); zeros(1,n)]/hy; 
    u_xx=[zeros(m,1), -u_xmas(:,1:end-1)+u_xmas(:,2:end)]/hx;
    u_yy=[zeros(1,n); -u_ymas(1:end-1,:)+u_ymas(2:end, :)]/hy;
    Lap=(u_xx+u_yy);
    % resuelvo la ecuacion
    u=u+dt*(Lap+lambda*(fn-u));
    fun=Lap.^2+lambda*((u-fn)).^2;
    func(1,k)=sum(fun(:));
    % calculo la energia de la diferencia de iteradas sucesivas
    diff_u(k)=sum((u(:)-u_prev(:)).^2);
end
    