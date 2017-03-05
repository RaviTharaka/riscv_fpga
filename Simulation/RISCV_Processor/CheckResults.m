clear all;
close all;

fileID = fopen('trace.txt','r');
trace = fscanf(fileID,'%08x\n');

fileID = fopen('Ins_Memory.txt','r');
ram = fscanf(fileID,'%08x\n');

results = zeros(length(trace),1);
for i = 1:length(trace)
   results(i,1) = ram(trace(i)/4+1); 
end

fileID = fopen('result.txt','r');
from_verilog = fscanf(fileID,'%08x\n');

error = (from_verilog(5:end) == results(1:length(from_verilog)-4));
