function [flipped] = InvRR(to_flip)

% Flip vector rows following the sequent structure:
% 1 2 3 4 -> 3 4 1 2 || 1 2 3 4 5 -> 3 4 5 1 2
% 
% [flipped] = InvRR(to_flip)
% Input argument:
% -------------------------------------------------
% to_flip   [nxm]   matrix to flip
%
% Output argument:
% -------------------------------------------------
% flipped   [nxm]   flipped matrix

dim = size(to_flip,1);                              % Input vector rows number 
dummy = zeros(size(to_flip));                       % Temporary matrix to work on

if rem(dim, 2) == 0                                 % Check rows are even
   dummy(1:dim/2, :) = to_flip(dim/2+1:end, :);
   dummy(dim/2+1:end, :) = to_flip(1:dim/2, :);
else                                                % If rows are odd the middle one will be
    dm = round(dim/2);                              % moved to the top
    dummy(1:dm, :) = to_flip(dm:end, :);
    dummy(dm+1:end, :) = to_flip(1:dm-1, :);
end

flipped = dummy;                                    % Return the flipped matrix

end