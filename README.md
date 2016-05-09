# Eight Queens unique solutions


## Introduction

The task of the n-queens puzzle is to place n=8 queens on an 8x8 chess board is such a fashion that no queens share the same row, column or diagonal. Since there must be a queen on each column and all their row number must differ a solution can be represented as a permutation of the columns. In a problem size of 8 there will be 92 overall solutions and 12 unique solutions. All of the 92 overall solutions can be transformed into one of the 12 unique solutions through rotations and reflections of the chess board.

##language requirements 
1. Groovy
2. GNU Octave
3. Python 3
4. Julia

##Algorithm

The implementation I choose for this task in the four languages start of by generating a permutation of the columns, this is equivalent to N! distinct possibilities and signify queens that are row and column safe. Since not all permutations are solutions each is check and only the ones in which all the queens are safe diagonally are kept. These permutations now represent the 92 overall solutions. After obtaining the 92 overall solutions I iterate through the list applying the symmetry in order to determine all possible variations. These 8 symmetry operations include three rotations of the board 90, 180, 270, reflection, and reflection followed by the three rotations. From the symmetry operations duplicates are able to be determined and eliminated. The result is the 12 unique solutions that an 8x8 board would produce.

##Execution

###Groovy
groovy groovy/nqueens.groovy

###GNU octave
octave octave/nqueens.m

###python 3
python3 python/nqueens.py

###Julia
julia julia/nqueens.jl