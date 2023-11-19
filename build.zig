const std = @import("std");



pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "hello",                                // name of the compiled file
        .root_source_file = .{ .path = "main.zig" },    // path to the main file
    });

    b.installArtifact(exe);

    // this section allow "zig build run" to function
    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);

    // might look to add additional commands to the above so "zig build run" defaults to "zig build run --summary all"

    // need to look at having it boot up gdb on the executable 
}