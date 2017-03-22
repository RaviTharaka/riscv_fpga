clear all;
close all;

% Address compression factor
fact = 1000000;

% Read trace data
fileID = fopen('gcc.trace','r');
formatSpec = '%c %x %d\n';
A = fscanf(fileID,formatSpec,[3 100000])';

% Reduce address space
mem_addr = A(:,2);
mem_addr_shifts = zeros(length(A),1);
max_addr = max(mem_addr);
step = round(max_addr/fact);
for i = 0 : step : max_addr
    temp = length(squeeze(mem_addr(mem_addr>=i & mem_addr<i+step)));
    if (temp == 0)
       mem_addr_shifts(mem_addr >= i + step) = mem_addr_shifts(mem_addr >= i + step) + 1;  
    end
end
mem_addr_out = mem_addr - mem_addr_shifts * step;
mem_addr_out = mem_addr_out - rem(mem_addr_out, 4);

figure;
subplot(2,1,1);
histogram(mem_addr,0.01*fact);
subplot(2,1,2);
histogram(mem_addr_out,100);

% Adding NOP terms
x = 1;
B = zeros(sum(A(:,3))+size(A,1),3);
for i = 1:size(A,1)
    if (A(i,1) == 115) 
        B(x,1) = 2;
    elseif (A(i,1) == 108)
        B(x,1) = 1;
    end
    B(x,2) = mem_addr_out(i,1);
    B(x+1:x+A(i,3),2) = randi(100000000,[1,A(i,3)]);
    x = x + A(i,3) + 1;
end

B(:,3) = randi(100000,[1,size(B,1)]);

% Write trace
fileID = fopen('gcc.trac','w');
fprintf(fileID,'%01x %08x %08x \n',B');
fclose all;

% Remove NOPs, convert to word addressable
C = B(B(:,1) ~= 0, :);
C(:,2) = C(:,2)/4; 

% Write memory initialization
rng(19);
max_mem_addr = 2^ceil(log2(max(C(:,2))));
% memory = randi(10000,[max_mem_addr,1]);
memory = (0 : 4 : 4 * max_mem_addr - 1)';
fileID = fopen('Mem_init.in','w');
fprintf(fileID,'%08x \n',memory');
fclose all;
