const std = @import("std");
const testing = std.testing;
const print = std.debug.print;

pub fn hello(name: []const u8) void {
    print("{s}\n", .{name});
}

pub fn add(a: usize, b: usize) usize {
    return a + b;
}

pub inline fn static_counter() *Counter {
    const Context = struct {
        var counter: Counter = .{};
    };
    return &Context.counter;
}

pub const Counter = struct {
    count: usize = 0,
    pub fn fetch_bump(self: *Counter) usize {
        defer self.count += 1;
        return self.count;
    }
    pub fn bump(self: *Counter) void {
        self.count += 1;
    }
};

test "static counter" {
    const f1 = struct {
        fn f() usize {
            var counter = static_counter();
            return counter.fetch_bump();
        }
    }.f;

    const f2 = struct {
        fn f() usize {
            var counter = static_counter();
            return counter.fetch_bump();
        }
    }.f;

    const f3 = struct {
        fn f() usize {
            var counter = static_counter();
            return counter.fetch_bump();
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
}
