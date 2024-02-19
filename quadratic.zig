const std = @import("std");

pub fn main() !void { // does not return
    var inputa: [16]u8 = undefined; // initializing memory u8 of size 16 as undefined
    var inputb: [16]u8 = undefined;
    var inputc: [16]u8 = undefined;
    const stdin = std.io.getStdIn().reader(); // creates the reader (need to read more about it)
    const stdout = std.io.getStdOut().writer(); // creates the writer (need to read more about it)

    // come back and update so that the depricated "readUntilDelimiter" is replaced with active reader

    try stdout.print("What is you value for a: ", .{});
    const a = try stdin.readUntilDelimiter(&inputa, '\n'); // must us "try" as this can fail returns a pointer to the buffer?

    try stdout.print("What is you value for b: ", .{});
    const b = try stdin.readUntilDelimiter(&inputb, '\n');

    try stdout.print("What is you value for c: ", .{});
    const c = try stdin.readUntilDelimiter(&inputc, '\n');

    // started using https://github.com/nvim-lua/kickstart.nvim
    // to search use "space" this brings up the telescope
    // with auto complete use "ctrl+n" and "ctrl-p" to navigate up and down
    // got to definition "gd" then use "ctrl+o" to get back
    // can use "ctrl+o" and "ctrl+i" to jump between back and forth
    // can also search ":Telescope keymaps"
    //
    // I where has this been all my life!

    // [-b +- sqrt(b^2 - 4ac)]/2a
    // use j for imaginary as i is for current (prepared to die on this hill)

    //try stdout.print("Value of \"a\": {s} (can't use a.* as that is giving \"index syntax required for slice type '[]u8' \", address {s} \n", .{a,&a});

    // convert an array of u8

    try stdout.print("The user entered: a:{s}, b:{s}, c:{s}\n", .{ a, b, c }); // printing can fail too
    // need to convert the values in the values within memory ([16]u8) to an u8 value
    // likely need a conversion to enable this

    // What is it's type
    //const sum = c+a;    // invalid operands to binary expression: 'Pointer' and 'Pointer'
    // NEED TO PARSE THE BUFFER TO AN REPRESENTATION THAT MAKES SENSE

    const parsed_a = try std.fmt.parseFloat(f32, a);
    const parsed_b = try std.fmt.parseFloat(f32, b);
    const parsed_c = try std.fmt.parseFloat(f32, c);

    const first_term = -parsed_b / 2 * parsed_a;
    const second_term_not_sqrt_num = (std.math.exp2(parsed_b)) - (4 * parsed_a * parsed_c);

    if (second_term_not_sqrt_num >= 0) {
        const second_term = (std.math.sqrt(second_term_not_sqrt_num)) / (2 * parsed_a);
        try stdout.print("The roots of the above function are {d} and {d}\n", .{ first_term + second_term, first_term - second_term });
    } else {
        const second_term = (std.math.sqrt(-1 * second_term_not_sqrt_num)) / (2 * parsed_a);
        try stdout.print("The roots of the above function are {d}±{d}j\n", .{ first_term, second_term });
    }
    // UNDERSTANDING TRANSITIVE FAILURES
    //
    // THIS DOES NOT COMPILE:
    // ------------------------------
    // try stdout.print("{d}\n", sum);
    // ------------------------------
    //
    // PRODUCES THE FOLLOWING ERROR:
    //
    // ----------------------------------------------------------------------------------------
    // zig build-exe quadratic Debug native: error: the following command failed with 1 compilation errors:
    // /home/mac/zig/zig-linux-x86_64-0.11.0/zig build-exe /home/mac/Desktop/ziglearn/quadratic.zig --cache-dir /home/mac/Desktop/ziglearn/zig-cache --global-cache-dir /home/mac/.cache/zig --name quadratic --listen=-
    // Build Summary: 0/3 steps succeeded; 1 failed (disable with --summary none)
    // run transitive failure
    // └─ run quadratic transitive failure
    //    └─ zig build-exe quadratic Debug native 1 errors
    // /home/mac/zig/zig-linux-x86_64-0.11.0/lib/std/fmt.zig:87:9: error: expected tuple or struct argument, found i32
    //         @compileError("expected tuple or struct argument, found " ++ @typeName(ArgsType));
    // -----------------------------------------------------------------------------------------
    //
    // FROM THE ERROR WE CAN SEE THAT THE ISSUE IS A RESULT OF ".../lib/std/fmt.zig:87:9"
    // GOING TO THE FILE IN QUESTION WE FIND THE FOLLOWING:
    // ---------------------------------------------------------
    //  86:    if (args_type_info != .Struct) {
    //  87:        @compileError("expected tuple or struct argument, found " ++ @typeName(ArgsType));
    //  88:    }
    //
    // FROM THIS DEFINITION WE CAN SEE THAT "fmt.zig" IS CHECKING TO SEE IF THE VALUE IS IN A STRUCT "FORM"
    // "sum" IS ONLY AN "i32" THIS DOES NOT MATCH WHAT IS REQUIRED, CHANGING TO ".{sum}" PUT IT IN THE CORRECT FORM

}
