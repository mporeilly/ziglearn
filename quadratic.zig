const std = @import("std");

pub fn main() !void {   // does not return 
    var inputa: [16]u8 = undefined;  // initializing memory u8 of size 16 as undefined 
    var inputb: [16]u8 = undefined;  // initializing memory u8 of size 16 as undefined 
    var inputc: [16]u8 = undefined;  // initializing memory u8 of size 16 as undefined 
    const stdin = std.io.getStdIn().reader(); // creates the reader
    const stdout = std.io.getStdOut().writer(); // creates the writer

    try stdout.print("What is you value for a: ",.{});
    const a = try stdin.readUntilDelimiter(&inputa, '\n'); // must us "try" as this can fail

    try stdout.print("What is you value for b: ",.{});
    const b = try stdin.readUntilDelimiter(&inputb, '\n'); // must us "try" as this can fail

    try stdout.print("What is you value for c: ",.{});
    const c = try stdin.readUntilDelimiter(&inputc, '\n'); // must us "try" as this can fail

    try stdout.print("The user entered: a:{s}, b:{s}, c:{s}\n", .{a,b,c});  // printing can fail too
}
