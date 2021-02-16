pkg load signal;

close all;
clear all;
Tu = 20;
Tcp = Tu/2;
T0 = Tu+Tcp;
al_base = 1/T0;
al_idx = [-5:5];
t_factor=0.1;
t_idx = [-T0:t_factor:T0];
alpha = al_base*al_idx;

for loop1 = 1:length(alpha)
  for loop2 = 1:length(t_idx)
    snc(loop1, loop2) = sinc(alpha(loop1)*(T0-abs(t_idx(loop2))));
  end
end
%figure (); mesh (t_idx, al_idx, snc);
figure (); plot (t_idx,snc(6,:));
hold on;
plot (t_idx,snc(5,:));
plot (t_idx,snc(4,:));
plot (t_idx,snc(3,:));
plot (t_idx,snc(2,:));
plot (t_idx,snc(1,:));
xlabel ('Lag \tau');
title ('Value of second component with different \alpha_n')
legend('n=0', 'n=1', 'n=2', 'n=3', 'n=4', 'n=5', "location", 'east')
grid on;
set (gca, 'xtick', [-T0,-Tu,0,Tu,T0])
set (gca, 'xticklabel', {'-T_o', '-T_u', '0', 'T_u', 'T_o'})

figure (); 
subplot (2, 2, 1)
stem(al_idx,snc(:,1+T0/t_factor));
xlabel ('Normalized \alpha_n');
title ('\tau=0')
subplot (2, 2, 2)
stem(al_idx,snc(:,1+(T0-Tcp)/t_factor));
xlabel ('Normalized \alpha_n');
title ('\tau=T_{cp}')

subplot (2, 2, 3)
stem(al_idx,snc(:,1+(T0-Tu)/t_factor));
xlabel ('Normalized \alpha_n');
title ('\tau=T_u')
subplot (2, 2, 4)
stem(al_idx,snc(:,1+0/t_factor));
xlabel ('Normalized \alpha_n');
title ('\tau=T_o')
%title ('Value of second component with different lag \tau')

%close all;
fsc = 1/Tu;
nsc = 256;
sc_idx = fsc*(1:nsc);
q = 5; %interleaving factor
sc(1,:) = ones(1,nsc);
tsc = zeros(1,nsc);
tsc(1:q:end) = 1;
sc(2,:) = tsc;
tsc = randi(2,1,nsc)-1;
tsc(1:4:end) = 1;
sc(3,:) = tsc;

for loop1 = 1:3
  for loop2 = 1:length(t_idx)
    lag = t_idx(loop2);
    dsc = exp(1j*2*pi*lag*sc_idx);
    caf1(loop1,loop2) = abs(sum(dsc.*sc(loop1,:)));
  end
end
figure (); 
subplot (3, 1, 1)
plot(t_idx,caf1(1,:))
title ('Contiguous subcarrier allocation')
axis ("tic", "labelx");
set (gca, 'xtick', [-T0,-Tu,0,Tu,T0])
set (gca, 'xticklabel', {'-T_o', '-T_u', '0', 'T_u', 'T_o'})


subplot (3, 1, 2)
plot(t_idx,caf1(2,:))
title ('Interleaved subcarrier allocation')
axis ("tic", "labelx");
set (gca, 'xtick', [-T0,-Tu,0,Tu,T0])
set (gca, 'xticklabel', {'-T_o', '-T_u', '0', 'T_u', 'T_o'})


subplot (3, 1, 3)
plot(t_idx,caf1(3,:))
title ('Random subcarrier allocation')
axis ("tic", "labelx");
set (gca, 'xtick', [-T0,-Tu,0,Tu,T0])
set (gca, 'xticklabel', {'-T_o', '-T_u', '0', 'T_u', 'T_o'})