import std / enumerate

let inputFile = open("input.txt")

var map: array[323, array[31, bool]]
var rowi: array[31, bool]

for iLine, line in enumerate lines inputFile:
    for iCell, cell in line:
        var val = false
        if cell == '#':
            val = true

        rowi[iCell] = val
    
    map[iLine] = rowi

let nRows = map.len
let nCols = map[0].len

proc countTreesForMovement(moveRight, moveDown:int):int =
    var row = 0
    var col = 0
    var nTrees = 0

    while true:
        if map[row][col]:
            nTrees += 1
        
        row += moveDown
        col += moveRight

        if row >= nRows:
            break
        
        if col >= nCols:
            col -= nCols
    
    return nTrees

echo countTreesForMovement(1, 1)
echo countTreesForMovement(3, 1)
echo countTreesForMovement(5, 1)
echo countTreesForMovement(7, 1)
echo countTreesForMovement(1, 2)