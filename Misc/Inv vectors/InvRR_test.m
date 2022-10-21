%% InvRR test

clear, clc
close all

theta1=linspace(-3.14,3.14,200);
theta2=linspace(-3.14,3.14,199);

theta1inv=InvRR(theta1);
theta2inv=InvRR(theta2);