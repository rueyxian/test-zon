const std = @import("std");
const testing = std.testing;
const print = std.debug.print;

pub fn hello(name: []const u8) void {
    print("{s}\n", .{name});
}

pub fn add(a: usize, b: usize) usize {
    return a + b;
}
