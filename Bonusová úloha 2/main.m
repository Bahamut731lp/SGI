%% Preambule
echo off;
clear;
clc;
close all;

%% Konstanty
% segmentation = 100;
subdivision = 8;
screensize = get(0, "ScreenSize");

%% Tělo programu
files = dir('data/*.jpg');
numberOfFiles = numel(files);

figureWindows = ceil(numberOfFiles / subdivision);
figureWidth = ceil(screensize(3) / figureWindows);

for i=1:numberOfFiles
    if (mod(i - 1, subdivision) == 0)
        noOfActiveFigures = length(findobj('type','figure'));
        figure('Units','pixels','Position',[noOfActiveFigures*figureWidth 0 figureWidth screensize(4)]);
        tiledlayout(subdivision, 3,'TileSpacing','tight','Padding','tight')
    end

    analyzeFile(strcat(files(i).folder,"/",files(i).name), files(i).name)
end

%%
function [avgX1, avgY1, avgX2, avgY2] = getAverage(x, y, arg)

    threshold = 3;

    [sortedXValues, sortedXIndices] = sort(x, arg);
    [sortedYValues, sortedYIndices] = sort(y, arg);
    
    yValuesforX = y(sortedXIndices);
    xValuesForY = x(sortedYIndices);

    avgX1 = mean(sortedXValues(end-threshold:end));
    avgY1 = mean(yValuesforX(end-threshold:end));

    avgX2 = mean(xValuesForY(1:threshold));
    avgY2 = mean(sortedYValues(1:threshold));
end

function rotate(data, angle)
    nexttile([1 1]);
    rotated = imrotate(data, angle);
    imshow(rotated)
end

function [angle] = getAngle(data)
    nexttile;
    dimensions = size(data);
    
    data = data(:, :, 1);
    filtered = data(:, :) < 220;
   
    disp();
%     hold on;
%     grid on;
%     axis equal;
%     axis([0,dimensions(1),0,dimensions(2)]);
%     
%     scatter(x, y);
%     
%     [avgX1, avgY1, avgX2, avgY2] = getAverage(x, y, "descend");
%     [avgX3, avgY3, avgX4, avgY4] = getAverage(x, y, "ascend");
% 
%     plot(avgX1, avgY1, 'ro', 'MarkerSize', 4, "Color", "red", "MarkerFaceColor", "red");
%     plot(avgX2, avgY2, 'ro', 'MarkerSize', 4, "Color", "magenta", "MarkerFaceColor", "magenta");
%     plot(avgX3, avgY3, 'ro', 'MarkerSize', 4, "Color", "blue", "MarkerFaceColor", "blue");
%     plot(avgX4, avgY4, 'ro', 'MarkerSize', 4, "Color", "green", "MarkerFaceColor", "green");
%     
%     A = [
%         avgX1, avgY1
%         avgX3, avgY3
%         avgX2, avgY2
%         avgX4, avgY4
%     ];
% 
%     [sortedY, YIndex] = sort(A(:, 2), "descend");
%     sortedX = A(:,1);
%     sortedX = sortedX(YIndex);
% 
%     x1 = mean(sortedX(1:2));
%     y1 = mean(sortedY(1:2));
% 
%     x2 = mean(sortedX(3:4));
%     y2 = mean(sortedY(3:4));
% 
%     plot(x1, y1, 'ro', 'MarkerSize', 4, "Color", "blue", "MarkerFaceColor", "yellow");
%     plot(x2, y2, 'ro', 'MarkerSize', 4, "Color", "blue", "MarkerFaceColor", "yellow");
% 
%     angle = atan((y2 - y1) / (x2 - x1));
%     plot([x1 x2], [y1 y2], Color="red");
%     hold off;
end

function analyzeFile(path, name) 
    nexttile;
    data = imread(path);
    imshow(data);
    
    [angle] = getAngle(data);
    
    degrees = rad2deg(angle);
    angleToRotate = -1 * sign(degrees) * 90 + degrees;

    if abs(angle) > 1e-5
        rotate(data, -angleToRotate);
    end

    fprintf("%s: %.2f (%.2f)\n", name, degrees, angleToRotate);
end