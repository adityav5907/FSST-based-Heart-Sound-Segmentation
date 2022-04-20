
figure

%finding fsst for a dataset
[s,w,n]=fsst(springer_dataset.audio_data(111),250,kaiser(128));

%for 3D figure
mesh(n,w/pi,abs(s))
axis tight
colorbar

