clear; clc;
close all

%% Hoffmann (Ex.2 ESE 5)

r_i = 6600;
R_L = 384000;
mu = 398600;

dv = trasferimento_Hoffmann(R_L, r_i, mu);

%% Hoffmann (Ex. 5 ESE 5)

AU = 149597870.700;
R_T = 1*AU;
R_M = 1.52*AU;
mu_s = 1.33e11;

dv = trasferimento_Hoffmann(R_M, R_T, mu_s);

%% Ellittico Bitangente (Ex.6.1 ESE 5)

a_1 = 10000;
e_1 = 0.1;
a_2 = 15000;
e_2 = e_1;
mu = 398600;

dv = trasferimento_Ellittico_Bitangente(a_1, a_2, e_1, e_2, mu, 'pa');

%% Ellittico Bitangente (Ex.6.2 ESE 5)

a_1 = 10000;
e_1 = 0.1;
a_2 = 15000;
e_2 = e_1;
mu = 398600;

dv = trasferimento_Ellittico_Bitangente(a_1, a_2, e_1, e_2, mu, 'ap');

%% Ellittico Bitangente (Ex.6.3.i ESE 5)

a_1 = 10000;
e_1 = 0.1;
a_2 = 15000;
e_2 = e_1;
mu = 398600;

dv = trasferimento_Ellittico_Bitangente(a_1, a_2, e_1, e_2, mu, 'pp');

%% Ellittico Bitangente (Ex.6.3.ii ESE 5)

a_1 = 10000;
e_1 = 0.1;
a_2 = 15000;
e_2 = e_1;
mu = 398600;

dv = trasferimento_Ellittico_Bitangente(a_1, a_2, e_1, e_2, mu, 'aa');

%% Ellittico Bitangente (Ex.6 totale ESE 5)

a_1 = 10000;
e_1 = 0.1;
a_2 = 15000;
e_2 = e_1;
mu = 398600;

dv = trasferimento_Ellittico_Bitangente(a_1, a_2, e_1, e_2, mu);
