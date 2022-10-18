function [rr_vect] = InvRR(rr_vect)

dim=size(rr_vect,1);

if rem(dim,2)==0
    for i=1:dim
        if i<= dim/2
            dummy(i,:)=rr_vect(dim/2+i,:);
        else
            dummy(i,:)=rr_vect(i-dim/2,:);
        end
    end
else
    error("Ancora da implementare");
end

rr_vect=dummy;

end