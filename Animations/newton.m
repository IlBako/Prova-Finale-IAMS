function [xvect,it]=newton(x0,nmax,toll,fun,dfun, mol)

% [xvect,it]=newton(x0,nmax,toll,fun,dfun) 
%
% Metodo di Newton per la ricerca degli zeri della
% funzione fun. Criterio d'arresto basato sul controllo
% della differenza tra due iterate successive.
%
% Parametri di ingresso:
%
% x0         Punto di partenza
% nmax       Numero massimo di iterazioni
% toll       Tolleranza sul test d'arresto
% fun dfun   inline functions contenenti la funzione e la sua derivata
% mol        Se presente, permette di effettuare il metodo di Newton
%            modificato
%
% Parametri di uscita:
%
% xvect      Vett. contenente tutte le iterate calcolate
%            (l'ultima componente e' la soluzione)
% it         Iterazioni effettuate

if (nargin == 5)
    mol = 1;
end

err = toll + 1;
it = 0;
xvect = x0;
xv = x0;

while (it< nmax && err> toll)
   dfx = dfun(xv);
   if dfx == 0
      error(' Arresto per azzeramento di dfun');
   else
      xn = xv - mol*fun(xv)/dfx;
      err = abs(xn-xv);
      xvect = [xvect; xn];
      it = it+1;
      xv = xn;
   end
end

% output non critical soppresso
if (it < nmax)
    %fprintf(' Convergenza al passo k : %d \n',it);
else
    fprintf(' E` stato raggiunto il numero massimo di passi k : %d \n',it);
end
    %fprintf(' Radice calcolata       : %-12.8f \n', xvect(end));