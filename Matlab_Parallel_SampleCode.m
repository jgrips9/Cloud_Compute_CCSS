%Start parallel processing, open up 4 core
parpool('local',4);
%Start Timer
tic 
%Run loop in parallel
parfor i=1:500000*1024
A(i) = sin(i*2*pi/1024);
end 
%Print timer
toc
%Stop parallel processing
delete(gcp('nocreate'))

%Start timer
tic 
%Perform same loop
for i=1:500000*1024
A(i) = sin(i*2*pi/1024);
end 
%Print timer
toc

%Check task manager to see the number of Matlab sessions running. 