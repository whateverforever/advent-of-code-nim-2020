import strutils

func combinationsOfThree[T](seqIn: seq[T]): seq[array[3, T]] =
    var outy: seq[array[3, T]]

    for itemA in seqIn:
        for itemB in seqIn:
            for itemC in seqIn:
                outy.add([
                    itemA, itemB, itemC
                ])

    return outy

proc main() =
    let inputFile = open("input.txt")
    var nums = newSeq[int]()

    # parse each line as int
    for line in lines(inputFile):
        nums.add(parseInt(line))

    for combi in combinationsOfThree(nums):
        let summy = combi[0] + combi[1] + combi[2]
        if summy == 2020:
            echo "combi: ", combi
            echo "product: ", combi[0] * combi[1] * combi[2]
            quit 0

when isMainModule:
    main()