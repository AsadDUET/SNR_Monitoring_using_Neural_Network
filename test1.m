clc
clear all
close all
N=2e5;
M=16;
snr_sample=2000;
m=randi([0 M-1],N,1);
s=qammod(m,M);
%pskmod(m, M);

a = 10;
b = 80;
EbNo = ((b-a).*rand(snr_sample,1) + a)';
% EbNo =10:20/1000:30;
% EbNo = randi([1 20],1000,.01);
% EbNo = EbNo';
SNR = EbNo+10*log10(log2(M));
%% Add Noise
fprintf('Adding Noise\n')
sn=ones(N,snr_sample);
M2s = ones(1,snr_sample);
M4s = ones(1,snr_sample);
M6s = ones(1,snr_sample);
M8s = ones(1,snr_sample);
M16s = ones(1,snr_sample);
MM = ones(1,snr_sample);
for n=1:length(EbNo)
    sn(:,n)=awgn(s,SNR(n),'measured');
    M2s(n) = mean(abs(sn(:,n)).^2);
    M4s(n) = mean(abs(sn(:,n)).^4);
    M6s(n) = mean(abs(sn(:,n)).^6);
    M8s(n) = mean(abs(sn(:,n)).^8);
    M16s(n) = mean(abs(sn(:,n)).^16);
%      d=pskdemod(sn,M);
%     [N_err,ber(n)] = biterr(m,d);
end
for n=1:length(EbNo)
    ind2 = find(real(sn(:,n))>0 & real(sn(:,n))<2 & imag(sn(:,n))<2 & imag(sn(:,n))>0);
    area = (max(real(sn(ind2,n)))-min(real(sn(ind2,n))))*(max(imag(sn(ind2,n)))-min(imag(sn(ind2,n))));
    MM(n) =(4/area);
end
fprintf('Normalizing\n')
MM=normalize(MM);
M2s=normalize(M2s);
M4s=normalize(M2s);
M6s=normalize(M2s);
M8s=normalize(M2s);
M16s=normalize(M2s);
%%
% plot(M4s )
% hold on
% plot(M2s )
% hold on
% plot(SNR)
% legend('M4','M2','SNR','Location','northwest')
% hold off
%semilogy(SNR,ber)
save('quam16_10-80_2e5_2000_normalized.mat','-v7.3')
fprintf('Done\n')

