train_set=1:1600;
test_set =1601:2000;
x = [M2s(train_set);M4s(train_set)];                                        
t = SNRdb(train_set);

%%Prepare Network
net = feedforwardnet([5],'trainlm');
net.inputs{1}.size = length(x(:,1)); 
net.trainParam.epochs = 20000;
net = configure(net,x);
net = init(net);
%%Train neural Network
[net,performance] = train(net,x,t);

%%Test and plot
view(net)
predictnn = net([M2s(test_set);M4s(test_set)]);                          
num =10*log10((sqrt(((M2s(test_set).^2).*2)-M4s(test_set)))./(M2s(test_set)-sqrt(((M2s(test_set).^2).*2)-M4s(test_set))));
figure(2)
plot(SNRdb(test_set),(SNRdb(test_set)-predictnn),'.')
hold on
plot(SNRdb(test_set),(SNRdb(test_set)-num),'.')
title('Result for 16 QAM')
xlabel('OSNR')
ylabel('Error')
legend('Proposed Method (M2,M4)', 'Standard M2, M4 Method','Location','northwest')

figure(3)
plot(SNRdb(test_set),predictnn,'.')
hold on
plot(SNRdb(test_set),num,'.') 
xlabel('Terget')
ylabel('Output')
