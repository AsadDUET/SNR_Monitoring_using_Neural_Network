% clc
% clear all
% close all

%% Prepare data
% load('quam16_10-80_1e5_1000.mat')
indices = find(abs(SNR)>1);
MMni= MMn(indices);
M8sni =M8sn(indices);
% x = {M2s;M4s;M8s;M10s;M12s;M14s;M16s;M64s};
x = {MMni;M8sni};                                        % <<<<
t = SNR(indices);

%% Prepare Network
net = feedforwardnet([5 5 25 25 5 5]);
net.numinputs = length(x);
% net.trainparam.goal=1e-12;
net.trainparam.lr=0.01;
net.trainParam.max_fail = 10;
net.trainParam.epochs = 20000;
net = configure(net,x);

%% Train neural Network
net = train(net,x,t);

%% Test and plot
view(net)
predictnn = net([MMni;M8sni]);                          % <<<<

figure(2)
subplot(2,2,1)
plot(t(1:100),'o')
hold on
plot(predictnn(1:100),'*')
legend('Actual SNR', 'Predicted SNR')
xlabel('Some Random Sample')
subplot(2,2,3)
plot(t,(t-predictnn),'.')
xlabel('SNR')
ylabel('Error')
subplot(2,2,[2,4])
% num =10*log10((sqrt(((M2s.^2).*2)-M4s))./(M2s.*sqrt(0.68)-sqrt(((M2s.^2).*2)-M4s)));
% a=1;
% num = (sqrt(((M2s(a)^2)*2)-M4s(a)))/(M2s(a)*sqrt(0.68)-sqrt(((M2s(a)^2)*2)-M4s(a)));
plot(t,predictnn,'.')
hold on
% plot(SNR,num,'.')
legend('Proposed Method', 'Standard M2, M4 Method','Location','northwest')
xlabel('Terget')
ylabel('Output')
%%

