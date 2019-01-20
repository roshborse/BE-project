
clc;
clear all;
close all;

fs=22000;

[f p]=uigetfile('*.*','Open speech signal');
fp=[p f];
%dirname=('D:\code1516\matlab1516\cummins\speaker identification\input1\u3.wav');
[y, fs] = wavread(fp);
    
vin = mfcc2(y);   
% vin = lpc(y);   
% vin = plp(y);  
 
 dirname=('D:\code1516\matlab1516\cummins\speaker identification\database1');

  cur_dir=cd;
  cd (dirname)
  dir_struct = dir(dirname);
  [sorted_names,sorted_index] = sortrows({dir_struct.name}');
  ind=max(sorted_index);
  cd(cur_dir) 

  for ii=3:ind
    
    fname=dir_struct(ii).name;
    tmp='\';
    fullpath=[dirname tmp fname];
    
    [y, fs] = wavread(fullpath);
    v = mfcc2(y);
   %  v = lpc(y);
   %  v = plp(y);
% %     codebook{ii-2} = vectorq(v,16);
 codebook{ii-2} = v;
        
  end    
   
  distmin = inf;
  k1 = 0;
 
  for l = 1:length(codebook)      % each trained codebook, compute distortion
      d = eqdist(vin, codebook{l});
      dist = sum(min(d,[],2)) / size(d,1)
      
      if dist < distmin
         distmin = dist;
         k1 = l;
      end      
  end

  nm=dir_struct(k1+2).name;
  
  
    l=length(nm);
    nmout=nm(1:l-4)       % skip .wav