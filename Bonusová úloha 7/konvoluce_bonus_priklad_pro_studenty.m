clear all
% x = [4, -2, 1, 0, 6, 2, 1, -2, 2]; % data vhodna na ladeni
% h = [3, 2, 1];  % data vhodna na ladeni

% Testovani na skutecnych datech
[zaznam, Fs] = audioread('hudba_orig.wav');   % nacteni kratkeho zaznamu 
x = zaznam';  % prevod na radkovy vektor
h = [1 2 3 4 5 4 3 2 1];  % priklad impulzni odezvy (trojuhelnikovy filtr)

disp ('Implementace Matlab')
tic
y = conv (x, h);
toc

disp ('Implementace vlastni')
tic
my_y = myconv (x, h);
toc

disp ('Rozdil mezi vystupy')
sum (my_y-y)


function y = myconv(x, h)
....

