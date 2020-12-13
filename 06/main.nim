import sets
import sequtils
import strutils
import std/enumerate

# let input = """abc

# a
# b
# c

# ab
# ac

# a
# a
# a
# a

# b"""

let input = readFile("input.txt")

var totalSum = 0
for igroup, group in enumerate input.split("\n\n"):
    var shit: HashSet[char]

    for iChoice, indivChoices in enumerate group.split("\n"):
        let indivChoicesSet = toHashSet toSeq indivChoices.items
        
        if iChoice == 0:
            shit = indivChoicesSet
        else:
            echo "Intersecting ", shit, " with ", indivChoicesSet
            shit = shit.intersection(indivChoicesSet)
    
    echo len shit
    totalSum += len shit

echo "Total ", totalSum