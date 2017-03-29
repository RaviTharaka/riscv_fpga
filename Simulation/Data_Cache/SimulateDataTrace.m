clear all;
close all; 

% Get the trace
fileID = fopen('gcc.trac','r');
formatSpec = '%x %x %x \n';
B = fscanf(fileID,formatSpec,[3 Inf])';

% Remove NOPs
% C = B(B(:,1) ~= 0, :);
C = B;
C(:,2) = C(:,2)/4; 

% Memory initialization
fileID = fopen('Mem_init.in','r');
formatSpec = '%x \n';
memory = fscanf(fileID,formatSpec,[1 Inf])';

% Results from FPGA
fileID = fopen('result.txt','r');
formatSpec = '%x\n';
fpga_out = fscanf(fileID,formatSpec,[1 Inf])';


% Generate outputs
sim_out = zeros(length(C),3);
z = 1;
for i = 1:length(C)
    if (C(i,1) == 2)                        % For a write
        memory(C(i,2)+1) = C(i,3);
    elseif (C(i,1) == 1)                    % For a read
        sim_out(z,1) = memory(C(i,2)+1);        % Read result
        sim_out(z,2) = i;                       % Position in FPGA
        sim_out(z,3) = C(i,2)*4;                % Read address
        z = z + 1;
    end
end
sim_out(1:length(fpga_out),4) = sim_out(1:length(fpga_out),1) - fpga_out;

no_of_errors = length(sim_out(sim_out(1:length(fpga_out),4)~=0,2))
requests     = length(fpga_out)
errors       = sim_out(sim_out(1:length(fpga_out),4)~=0,:);

errors(:,4) = errors(:,1)-errors(:,4);

B(:,4) = 1:length(B);
D = B(B(:,1) ~= 0, :);

req=sim_out(sim_out(1:length(fpga_out),3)==85608,:);
seq=D(D(1:end,2)==85608,:);

