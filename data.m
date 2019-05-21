clc
close all
clear all
N=1e5;
M=16;
snr_sample=2000;
m=randi([0 M-1],N,1);
s=qammod(m,M);
 
a = 1;
b = 30;
EbNo = ((b-a).*rand(snr_sample,1) + a)';
SNRdb = EbNo+10*log10(log2(M));
 
fprintf('Adding Noise\n')
Ms = ones(1,snr_sample);
M2s = ones(1,snr_sample);
M4s = ones(1,snr_sample);
MMs = ones(1,snr_sample);
%% Add Noise
for n=1:length(SNRdb)
    sn=awgn(s,SNRdb(n),'measured');
    index = find(abs(sn)<(abs(3+3i)+abs(3+1i))/2 & abs(sn)>(abs(1+1i)+abs(3+1i))/2);
    M2s(n) = mean(abs(sn(index)).^2);
    M4s(n) = mean(abs(sn(index)).^4);
    MMs(n) = 1/mean((abs(sn(index))-abs(3+1i)).^2);
end
 
%% Save data
save('quam16_1-30_1e5_2000_4.mat','-v7.3')
fprintf('Done\n')
