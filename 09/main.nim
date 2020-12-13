import std/enumerate
import strutils
import sequtils

func isSumOfSome(someNum: int, candidateFactors: seq[int]): bool =
    for candidate in candidateFactors:
        if (someNum - candidate) in candidateFactors:
            return true
    return false

when isMainModule:
    const LEN_PREAMBLE = 25
    let input = readFile("input.txt")

    var stack: seq[int]
    for line in input.split("\n"):
        stack.add(line.parseInt())

    echo "#### Part 1"
    var problemNum = -1
    for idx, targetNum in enumerate stack:
        if idx >= LEN_PREAMBLE:
            let candidateFactors = stack[idx-LEN_PREAMBLE..idx-1]

            if not isSumOfSome(targetNum, candidateFactors):
                echo targetNum, " is the issue"
                problemNum = targetNum
                break
    
    echo "#### Part 2"
    for idx, num in enumerate stack:
        var tempSum = 0
        var horizon: seq[int]
        for horizonNum in stack[idx..^1]:
            tempSum += horizonNum
            horizon.add(horizonNum)

            if tempSum == problemNum:
                echo "Window starts at ", num, " ends at ", horizonNum
                echo horizon, horizon.foldl(a+b)
                echo horizon.min, " --> ", horizon.max, " ==> ", horizon.min + horizon.max
                quit 0

