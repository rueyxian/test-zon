const std = @import("std");
const testing = std.testing;
const print = std.debug.print;

// export fn add(a: i32, b: i32) i32 {
//     return a + b;
// }

export fn hello(name: []const u8) void {
    print("{}\n", .{name});
}

// test "basic add functionality" {
// try testing.expect(add(3, 7) == 10);
// }
