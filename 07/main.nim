import tables
import nre
import sequtils
import strutils

type ColorWithCount = tuple
    color: string
    count: int

proc parseBagRules(rules: string): Table[string, seq[ColorWithCount]] =
    let REX_RULE = re"(.+?) bags contain (.+)"
    let REX_CHILDREN = re"(\d+) ([^\.,]+) bags?"

    var parentsForColor: Table[string, seq[ColorWithCount]]

    for ruleMatch in findIter(rules, REX_RULE):
        let parentColor = ruleMatch.captures[0]
        let rawChildrenString = ruleMatch.captures[1]

        # Since everyone can be a child even if not mentioned on the right of a rule
        if not (parentColor in parentsForColor):
            parentsForColor[parentColor] = @[]

        for childMatch in findIter(rawChildrenString, REX_CHILDREN):
            let numChildBags = childMatch.captures[0].parseInt
            let childColor = childMatch.captures[1]

            if not (childColor in parentsForColor):
                parentsForColor[childColor] = @[]

            parentsForColor[childColor].add((parentColor, numChildBags))

    return parentsForColor

func get_possible_parents(rules: Table[string, seq[ColorWithCount]], colors: seq[ColorWithCount]): seq[ColorWithCount] =
    var res: seq[ColorWithCount] = @[]

    for (color, count) in colors:
        for parentBag in rules[color]:
            res.add(parent_bag)

    return res

when isMainModule:
    #let rules = readFile("input.txt")
    let rules = """shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags."""

    let myBag = ("shiny gold", 0)
    let parentsForColor = parseBagRules(rules)

    var bagsToCheck = @[myBag]
    var possibleParents: seq[ColorWithCount] = @[]

    while true:
        let parents = get_possible_parents(parentsForColor, bagsToCheck)
        if parents.len == 0:
            break
        
        bagsToCheck = get_possible_parents(parentsForColor, parents)

        possibleParents.add(parents)
        possibleParents.add(bagsToCheck)

    possibleParents = possibleParents.deduplicate()
    echo "Result: ", len(possibleParents)