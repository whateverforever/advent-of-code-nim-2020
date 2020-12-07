import strutils

let inputFile = open("input.txt")
var nums = newSeq[int]()

# parse each line as int
for line in lines(inputFile):
    nums.add(parseInt(line))

var cmpStartIndex = 0
while cmpStartIndex < len(nums):
    for other in nums[cmpStartIndex..^1]:
        if nums[cmpStartIndex] + other == 2020:
            echo "current: ", nums[cmpStartIndex], " other: ", other
            echo "--> ", nums[cmpStartIndex] * other
            quit 0

    cmpStartIndex += 1