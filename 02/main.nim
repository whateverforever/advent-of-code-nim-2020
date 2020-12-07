import nre
import strutils

let inputFile = open("input.txt")
let lineRex = re"(\d+)\-(\d+)\s(\w):\s(\w+)"

proc isValidPassword(password: string, verbose: bool = false, policy: int = 1): bool =
    for m in findIter(password, lineRex):
        let lower = parseInt m.captures[0]
        let upper = parseInt m.captures[1]
        let letter = m.captures[2]
        let password = m.captures[3]

        if verbose:
            echo "password: ", password
            echo "lower: ", lower, " upper: ", upper, " letter: ", letter, " password: ", password
        
        let numOccurences = password.count(letter)

        if policy == 1:
            if numOccurences >= lower and numOccurences <= upper:
                return true
            return false
        else:
            let firstOK = (password[lower - 1]) == letter[0]
            let secondOK = (password[upper - 1]) == letter[0]

            if (firstOK or secondOK) and not (firstOK and secondOK):
                return true
            return false

when isMainModule:
    var validPolicy1 = 0
    var invalidPolcy1 = 0

    var validPolicy2 = 0
    var invalidPolcy2 = 0

    for pw in lines inputFile:
        if isValidPassword(pw, policy=2):
            validPolicy1 += 1
        else:
            invalidPolcy1 += 1
    
    echo "We have ", validPolicy1, " valid passwords"
    echo "and ", invalidPolcy1, " invalid ones"