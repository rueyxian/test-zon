const std = @import("std");
const testing = std.testing;
const print = std.debug.print;

pub fn hello(name: []const u8) void {
    print("{s}\n", .{name});
}

pub fn add(a: usize, b: usize) usize {
    return a + b;
}

pub const Counter = struct {
    count: usize = 0,
    pub fn fetchBump(self: *Counter) usize {
        defer self.count += 1;
        return self.count;
    }
    pub fn bump(self: *Counter) void {
        self.count += 1;
    }
};

test "static counter" {
    const f1 = struct {
        var counter = Counter{};
        fn f() usize {
            return counter.fetchBump();
        }
    }.f;

    const f2 = struct {
        var counter = Counter{};
        fn f() usize {
            return counter.fetchBump();
        }
    }.f;

    const f3 = struct {
        var counter = Counter{};
        fn f() usize {
            return counter.fetchBump();
        }
    }.f;

    try testing.expect(f1() == 0);
    try testing.expect(f1() == 1);
    try testing.expect(f2() == 0);
    try testing.expect(f1() == 2);
    try testing.expect(f3() == 0);
    try testing.expect(f2() == 1);
    try testing.expect(f3() == 1);
    try testing.expect(f2() == 2);
    try testing.expect(f2() == 3);
    try testing.expect(f3() == 2);
    try testing.expect(f2() == 4);
    try testing.expect(f1() == 3);

    // try testing.expect(false);
}
