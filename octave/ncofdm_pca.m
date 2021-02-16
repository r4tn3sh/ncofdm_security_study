pkg load statistics
pkg load signal
close all;
clear all;

bw = 20e6;
% total number of subcarriers
totnsc = 256;
% Actual number of subcarriers
nsc = 100;
%number of samples
nsamps = 50000;
nblks = ceil(nsamps/nsc);
% generate BPSK samples
samps = 2*(randi(2,nsamps,1))-3;
samps_in = reshape(samps,nsc,nblks);
samps_out = fft(samps_in,totnsc)/sqrt(totnsc);
samps_out_s = reshape(samps_out, totnsc*nblks, 1);

delay = 0;

figure();
d = 320;
%delay = 5
for delay = 0:5:20
%for d = 300:20:400
  samps_rs = resample(samps_out_s(1+delay:end),5,4);
  l1 = floor(length(samps_rs)/d);
  samps_rs_blk = reshape(samps_rs(1:d*l1), d, l1);
  eg = svd(samps_rs_blk);
  
  if delay==0
  %if d==320
    plot(log10(eg), "-*");
  else
    plot(log10(eg));
  end
  hold on;
end
xlim([80,110]);
ylim([0,1.5]);
title('Time offset from PCA analysis (100 out of 256 subcarriers)');
grid on;
grid minor;
xlabel('Eigenvalue index')
ylabel('Sorted eigenvalue strength (log scale)')
axis ("tic", "labelx");
%legend('300', '320', '340', '360', '380', "400")
%legend('0', '5', '10', '360', '380', "400")