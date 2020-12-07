import strutils
import nre
import sets

let REQUIRED_FIELDS = toHashSet(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])

let REX_FIELD = re"(\w{3}):([#0-9a-zA-Z]+)"
let REX_HEIGHT = re"(\d+)(in|cm)"
let REX_HEXCOLOR = re"#[0-9a-f]{6}"
let REX_STRCOLOR = re"(amb|blu|brn|gry|grn|hzl|oth)"
let REX_PID = re"\d{9}"
let REX_YEAR = re"(\d{4})"

proc isValidYear(str: string, lower, upper: int): bool =
    let match = find(str, REX_YEAR)
    if isNone match:
        return false
    let year = match.get().captures[0].parseInt()
    return year >= lower and year <= upper

proc isFieldValid(fieldName, fieldVal: string): bool =
    case fieldName:
    of "byr":
        return isValidYear(fieldVal, 1920, 2002)
    of "iyr":
        return isValidYear(fieldVal, 2010, 2020)
    of "eyr":
        return isValidYear(fieldVal, 2020, 2030)
    of "hgt":
        let match = find(fieldVal, REX_HEIGHT)
        if isNone match:
            return false
        let height = match.get().captures[0].parseInt()
        let unit = match.get().captures[1]

        case unit:
        of "cm":
            return height >= 150 and height <= 193
        of "in":
            return height >= 59 and height <= 76
    of "hcl":
        return fieldVal.contains(REX_HEXCOLOR)
    of "ecl":
        return fieldVal.contains(REX_STRCOLOR)
    of "pid":
        if fieldVal.len > 9:
            return false
        return fieldVal.contains(REX_PID)

proc main() =
    let inputFile = readFile("input.txt")
    let passports = inputFile.split("\n\n")
    var numValidPassports = 0

    for passportFields in passports:
        var fieldsPresent: seq[string]

        for finding in findIter(passportFields, REX_FIELD):
            if isFieldValid(finding.captures[0], finding.captures[1].strip()):
                fieldsPresent.add(finding.captures[0])

        let fieldsPresent2 = toHashSet(fieldsPresent)
        let fieldsMissing = REQUIRED_FIELDS - fieldsPresent2

        if len(fieldsMissing) > 1:
            continue

        if len(fieldsMissing) == 1 and not ("cid" in fieldsMissing):
            continue

        numValidPassports += 1

    echo "numValidPassports: ", numValidPassports

when isMainModule:
    main()
