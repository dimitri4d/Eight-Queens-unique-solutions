/*
Dimitri Frederick
nqueens.groovy

modified from https://rosettacode.org/wiki/N-queens_problem#Groovy
*/

def listOrder = { a, b ->
    def k = [a.size(), b.size()].min()
    def i = (0..<k).find { a[it] != b[it] }
    (i != null) ? a[i] <=> b[i] : a.size() <=> b.size()
}

def orderedPermutations = { list ->
    def n = list.size()
    (0..<n).permutations().sort(listOrder)
}

def diagonalSafe = { list ->
    def n = list.size()
    n == 1 || (0..<(n-1)).every{ i ->
        ((i+1)..<n).every{ j ->
            !([list[i]+j-i, list[i]+i-j].contains(list[j]))
        }
    }
}

def queensDistinctSolutions = { n ->
    orderedPermutations((0..<n)).findAll (diagonalSafe)
}

class Reflect {
    public static final diag = { list ->
        final n = list.size()
        def tList = [0] * n
        (0..<n).each { tList[list[it]] = it}
        tList
    }

    public static final vert = { list ->
        list.reverse()
    }

    public static final horiz = { list ->
        final n = list.size()
        list.collect { n - it - 1 }
    }
}

enum Rotations {
    r0([]),
    r90([Reflect.vert, Reflect.diag]),
    r180([Reflect.vert, Reflect.diag, Reflect.vert, Reflect.diag]),
    r270([Reflect.diag, Reflect.vert]);

    private final List operations

    private Rotations(List ops) {
        operations = ops ?: []
    }

    public static void eliminateDups(primary, solutions) {
        (r0..r270).each { rot -> rot.eliminateDuplicates(primary, solutions)}
    }

    private void eliminateDuplicates(primary, solutions) {
        def rotated = [] + primary
        operations.each { rotated = it(rotated) }
        solutions.removeAll([rotated, Reflect.vert(rotated)])
    }
}

def queensUniqueSolutions = { start ->
    assert start instanceof Number || start instanceof List
    def qus = (start instanceof Number) \
    ? queensDistinctSolutions(start) \
    : [] + start
    for (def i = 0; i < qus.size()-1; i++) {
        Rotations.eliminateDups(qus[i], qus[(i+1)..<(qus.size())])
    }
    qus
}

def qds = queensDistinctSolutions(8)
def qus = queensUniqueSolutions(qds)
println (["unique solutions":qus.size()])
qus.each { println it }
