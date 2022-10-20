function [f_elaborata] = zzz_derint(f,scelta,grado)

%   derivata(1) o integrale(2)
%   grado: il grado scelto per l'operazione

f_sym = str2sym(char(f));

if grado<0
    error("Il grado non può essere negativo");
end


for i=1:grado
    if scelta==1
        f_sym=diff(f_sym);
    elseif scelta==2
        f_sym=int(f_sym);
    else
        error("Non è stata scelta correttamente l'operazione da eseguire");
    end
end

f_nuova=str2func(vectorize(f_sym));
var=symvar(char(f));
sym2str=['@(',sprintf('%s,',var{1:end-1}),var{end},') ',char(f_nuova)];
f_elaborata=str2func(vectorize(sym2str));


end