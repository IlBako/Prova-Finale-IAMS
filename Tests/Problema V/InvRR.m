function [rr_vect] = InvRR(rr_vect)

dim=size(rr_vect,1);

% if rem(dim,2)==0
%     for i=1:dim
%         if i<= dim/2
%             dummy(i,:)=rr_vect(dim/2+i,:);
%         else
%             dummy(i,:)=rr_vect(i-dim/2,:);
%         end
%     end
% else
%     error("Ancora da implementare");
% end

dummy = zeros(size(rr_vect));

if rem(dim, 2) == 0
   dummy(1:dim/2, :) = rr_vect(dim/2+1:end, :);
   dummy(dim/2+1:end, :) = rr_vect(1:dim/2, :);
else
    dm = round(dim/2);
    dummy(1:dm, :) = rr_vect(dm:end, :);
    dummy(dm+1:end, :) = rr_vect(1:dm-1, :);
end

rr_vect=dummy;

end