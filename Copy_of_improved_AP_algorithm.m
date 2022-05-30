function [converse,center] = improved_AP_algorithm(x,p)

N = size(x,1)
M = N*N-N
s = zeros(M,3)

j = 1
for i = 1 : N
    for k = [1 : i-1,i+1 : N]
        s(j,1) = i
        s(j,2) = k
        s(j,3) = -sum((x(i,:)-x(k,:)).^2)
        j = j + 1
    end
end

tmp = max(max(s(:,1)),max(s(:,2)))
S = -inf*ones(N,N)
for j = 1 : size(s,1)
    S(s(j,1),s(j,2)) = s(j,3)
end
nonoise = 1
if length(p) == 1
    for i = 1 : N
        S(i,i) = p
    end
else
    for i = 1 : N
        S(i,i) = p(i)
    end
end


for i = 1 : size(S,1)
    for j = 1 : size(S,2)
        if x(i,3) < x(j,3)
            S(i,j) = S(i,j)+(x(j,3)-x(i,3))*min(x(:,3))/median(x(:,3))
        end
    end
end
        
dS = diag(S)
A = zeros(N,N)
R = zeros(N,N)
convits = 50
maxits = 500
e = zeros(N,convits)
dn = 0;i = 0
while ~dn
    i = i + 1
    Rold = R
    AS = A + S
    [Y,I] = max(AS,[],2)
    for k = 1 : N
        AS(k,I(k)) = -realmax
    end
    [Y2,I2] = max(AS,[],2)
    R = S - repmat(Y,[1,N])
    
    for k = 1 : N
        R(k,I(k)) = S(k,I(k)) - Y2(k)
    end
    lam = 0.5
    R = (1-lam)*R + lam*Rold
    Aold = A
    Rp = max(R,0)
    for k = 1 : N
        Rp(k,k) = R(k,k)
    end
    A = repmat(sum(Rp,1),[N,1])-Rp
    dA = diag(A)
    A = min(A,0)
    for k = 1 : N
        A(k,k) = dA(k)
    end
    A = (1-lam)*A + lam*Aold
    E = ((diag(A) + diag(R)) > 0)
    e(:,mod(i-1,convits)+1) = E
    E = sum(E)
    if i >= convits || i >= maxits
        se = sum(e,2)
        unconverged = (sum((se==convits)+(se==0))~=N)
        if (~unconverged&&(k>0))||(i == maxits)
            dn = 1
        end
    end
end

I = find(diag(A+R)>0)
K = length(I)
if K>0
    [~,c] = max(S(:,I),[],2)
    c(I) = 1 : K
    for k = 1 : K
        ii = find(c == k)
        [y,j] = max(sum(S(ii,ii),1))
        I(k) = ii(j(1))
    end
    [tmp,c] = max(S(:,I),[],2)
    c(I) = 1 : K
    tmpidx = I(c)
    tmpnetsim = sum(S((tmpidx-1)*N+(1:N)'))
    tmpexpref = sum(dS(I))
else
    tmpidx = nan*ones(N,1)
    tmpnetsim = nan
    tmpexpref = nan
end
netsim = tmpnetsim
dpsim = tmpnetsim - tmpexpref
expref = tmpexpref
idx = tmpidx
unique(idx)
fprintf('Number of clusters:%d\n',length(unique(idx)))
fprintf('Fitness(net similarity):%g\n',netsim)
figure
the_center_points = []
the_result = []
for i = unique(idx)'
    ii = find(idx == i)
    h = plot(x(ii,1),x(ii,2),'o')
    g = [h.XData h.YData]
    hold on
    col = rand(1,3)
    set(h,'Color',col,'MarkerFaceColor',col)
    xi1 = x(i,1)*ones(size(ii))
    xi2 = x(i,2)*ones(size(ii))
    xi = [xi1 xi2]
    the_center_points = [the_center_points;xi]
    line([x(ii,1),xi1]',[x(ii,2),xi2]','Color',col)

    the_result = [the_result 0 g]
    
end

center = [the_center_points(1,:)]
for i = 2 : size(the_center_points,1)
    if the_center_points(i-1,1) ~= the_center_points(i,1) || the_center_points(i-1,2) ~= the_center_points(i,2)
        center = [center;the_center_points(i,:)]
    end
end
hold on
for i = 1 : size(center,1)
    plot(center(i,1),center(i,2),'k*')
end
axis equal
the_result = [the_result 0]
location_0 = find(the_result == 0)   %%%记录0的位置

%%%%%%%重新排序%%%%%%%%
t = []
for i = 1 : size(location_0,2)-1
   f = the_result(1,location_0(1,i)+1:location_0(1,i+1)-1)
   size_f = size(f,2)
   for k = 1 : size_f/2
      ty = [f(k) f(k+size_f/2)]
      t = [t ty ]
   end
   t = [t 0]
end

the_result = [0 t]
converse1 = []
for i = 1 : size(location_0,2)-1
    for j = 1 : 1 : (location_0(1,i+1)-location_0(1,i)-1)/2
        first = the_result(location_0(1,i)+2*(j-1)+1)
        second = the_result(location_0(1,i)+2*(j-1)+2)
        location = [first second]
        for k = 1 : size(x,1)
           if location(1,1) == x(k,1) && location(1,2) == x(k,2)
               converse1 = [converse1 k]
           end
        end
    end
end

converse = [0]
for i = 1 : size(location_0,2)-1
    converse2 = converse1(1,1:(location_0(1,i+1)-location_0(1,i)-1)/2) 
    converse1(1:size(converse2,2)) = []
    converse = [converse converse2 0]
end
end