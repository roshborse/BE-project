clc;
clear all;
close all;
disp('start speaking'); 
fs=44100;
s=wavrecord(2*22000,44100,'int16');   %for recording
disp('end of recording');              
wavplay(s*10,44100);                     %for playing
wavwrite(s*10,44100,'shweta3');          %for saving as .wave file
plot(s);

