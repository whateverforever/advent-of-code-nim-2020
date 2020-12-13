import strutils
import nre
import std/enumerate

type Instruction = tuple
    cmd: string
    val: int

type ExecutionResult = tuple
    success: bool
    accumulator: int

let cmdRex = re"(\w{3}) ((\+|-)\d+)"
let input = readFile("input.txt")

echo "> Parsing Commands"

var commands: seq[Instruction] = @[]
for line in input.split("\n"):
    let res = match(line, cmdRex)
    let cmd = res.get().captures[0]
    let val = res.get().captures[1].parseInt()

    commands.add((cmd, val))

echo "! Parsed Commands"
echo "    ", commands
echo "> Starting execution"

func executeCommands(commands: seq[Instruction]): ExecutionResult =
    var accumulator = 0
    var instrIdx = 0
    var instrHistory: seq[int] = @[]

    while true:
        if instrIdx in instrHistory:
            return (false, accumulator)

        instrHistory.add(instrIdx)
        try:
            let (cmd, val) = commands[instrIdx]
            case cmd:
                of "acc":
                    accumulator += val
                of "jmp":
                    instrIdx += val
                    continue
        except IndexDefect:
            return (true, accumulator)
        instrIdx += 1

let (success, accumulator) = executeCommands(commands)
echo "Succ? ", success, " accumulator? ", accumulator

var commandVariations: seq[seq[Instruction]] = @[]
for idx, (cmd, val) in enumerate commands:
    if cmd == "jmp":
        var cmdCopy = commands
        cmdCopy[idx][0] = "nop"
        commandVariations.add(cmdCopy)
    elif cmd == "nop":
        var cmdCopy = commands
        cmdCopy[idx][0] = "jmp"
        commandVariations.add(cmdCopy)

echo "Created ", len(commandVariations), " variations of the source code"

for cmdVariation in commandVariations:
    let (success, accumulator) = executeCommands(cmdVariation)

    if success:
        echo "Success: ", accumulator
        break