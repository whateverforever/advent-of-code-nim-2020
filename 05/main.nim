import algorithm
import std/enumerate

type SeatRange = tuple
    lower_incl: int
    upper_incl: int

type Seat = tuple
    row: int
    col: int
    id: int

func len(myRange: SeatRange): int =
    return myRange.upper_incl - myRange.lower_incl + 1

func lowerHalf(myRange: SeatRange): SeatRange =
    return (myRange.lower_incl, myRange.lower_incl + int(myRange.len/2) - 1)

func upperHalf(myRange: SeatRange): SeatRange =
    return (myRange.lower_incl + int(myRange.len/2), myRange.upper_incl)

func parseSeatCode(seatCode: string): Seat =
    var rowRange: SeatRange = (0,127)
    var colRange: SeatRange = (0, 7)

    for partition in seatCode[..6]:
        if partition == 'F':
            rowRange = rowRange.lowerHalf
        elif partition == 'B':
            rowRange = rowRange.upperHalf

    for partition in seatCode[7..^1]:
        if partition == 'L':
            colRange = colRange.lowerHalf
        elif partition == 'R':
            colRange = colRange.upperHalf
    
    return (rowRange.lower_incl, colRange.lower_incl, rowRange.lower_incl * 8 + colRange.lower_incl)

proc main() =
    let inputFile = open("input.txt")
    
    var maxSeatId = -1
    var allSeatIds: seq[int]
    for seatCode in lines inputFile:
        let (_, _, id) = parseSeatCode(seatCode)
        
        allSeatIds.add(id)

        if id > maxSeatId:
            maxSeatId = id

    echo "Max Seat Id is ", maxSeatId

    allSeatIds = sorted(allSeatIds)
    for iSeat, seatId in enumerate allSeatIds[0..^2]:
        if allSeatIds[iSeat + 1] - seatId > 1:
            echo "Here's the missing seat: ", seatId, " ... ", allSeatIds[iSeat + 1]

when isMainModule:
    main()