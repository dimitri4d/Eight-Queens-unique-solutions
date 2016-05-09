#! octave-interpreter-name -qf
# Dimitri Frederick
# nqueens.m

% permutation of possible values and check if diagonally safe
function [ distinctSolutions ] = get_distinct( )
    % get permutation of of columns
    permutations = perms([1 2 3 4 5 6 7 8]);

    % add diagonally safe solutions to distinctSolutions
    distinctSolutions = [];
    for i = 1:length(permutations),
        sol = permutations(i,:);
        if diagonalSafe(sol) == true
            distinctSolutions = [distinctSolutions; sol];
        end
    end
end

% check diagonals
function [ result ] = diagonalSafe( sol )
    for i = 2:8,j = i-1;
        while j ~= 0,
            if sol(i)+j == sol(i-j)
                result = false;
                return
            elseif sol(i)-j == sol(i-j)
                result = false;
                return
            end
            j = j-1;
        end
    end
    result = true;
end


% get unique solutions by performing symmetry operations
function [ uniqueSolutions ] = get_unique(solutions )

    uniqueSolutions = [];
    #solutions = sortrows(sols);
    for i = 1:length(solutions),
        # the eight possible symmetry operations
        sol = solutions(i,:);
        r90 = rotate (sol);
        r180 = rotate (rotate (sol));
        r270 = rotate (rotate (rotate (sol)));
        ref = reflect (sol);
        ref90 = rotate (reflect (sol));
        ref180 = rotate (rotate (reflect (sol)));
        ref270 = rotate (rotate (rotate (reflect (sol))));

        % replace the duplicate rows found through symmetry ops with NAN
        for x = i+1:length(solutions),
            if isequal(r90,solutions(x,:))
                solutions(i,:) = NaN;
            elseif
                isequal(r180,solutions(x,:))
                solutions(i,:) = NaN;
            elseif
                isequal(r270,solutions(x,:))
                solutions(i,:) = NaN;
            elseif
                isequal(ref,solutions(x,:))
                solutions(i,:) = NaN;
            elseif
                isequal(ref90,solutions(x,:))
                solutions(i,:) = NaN;
            elseif
                isequal(ref180,solutions(x,:))
                solutions(i,:) = NaN;
            elseif
                isequal(ref270,solutions(x,:))
                solutions(i,:) = NaN;
            end
        end
    end

    # delete all the rows with NAN values in the array list
    solutions(any(isnan(solutions),2),:) = [];
    uniqueSolutions= solutions;
end

%  rotation
function [ result ] = rotate( sol )
    result = zeros(1,8);
    for i = 1:8,
        pos = find(sol == i);
        result(i) = 9-pos;
    end
end

% reflection
function [ result ] = reflect( sol )
    result = sol;
    for i = 1:8,
        result(i) = 9- result(i);
    end
end

% distinct solutions
distinctSolutions = get_distinct();
% unique solutions
uniqueSolutions= get_unique(distinctSolutions)
length(uniqueSolutions)
