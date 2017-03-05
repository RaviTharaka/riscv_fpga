clear all;
close all;

x = 1:2^10;

fileID = fopen('Ins_Memory.txt','w');
fprintf(fileID,'%08x\n',x);
fclose(fileID);