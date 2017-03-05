clear all;
close all;

x = 0:4:2^10;

fileID = fopen('trace.txt','w');
fprintf(fileID,'%08x\n',x);
fclose(fileID);