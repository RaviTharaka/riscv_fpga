clear all;
close all;

fileID = fopen('result.txt','r');
formatSpec = '%x';

A = fscanf(fileID,formatSpec);
A = int64(A);

fileID = fopen('trace.txt','r');
formatSpec = '%x';
B = fscanf(fileID,formatSpec);
B = int64(B);
x = size(A,1) - 3;

C = A(4:end) - B(1:x);

number_of_requests_in_error = sum(abs(C)>4)
total_requests = size(C,1)
errors = find(abs(C)>3);
fprintf('%x', B(538));