const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Export module
    const mod = b.addModule("test_zon", .{ .source_file = .{ .path = "src/root.zig" } });
    _ = mod;

    // const mod = b.createModule("test_zon", .{ .source_file = .{ .path = "src/root.zig" } });
    // try b.modules.put(b.dupe("test_zon"), mod);

    const lib = b.addStaticLibrary(.{
        .name = "test_zon",
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    const test_step = b.step("test", "Run unit tests");
    {
        const unit_tests = b.addTest(.{
            .root_source_file = .{ .path = "src/root.zig" },
            .target = target,
            .optimize = optimize,
        });

        const run_unit_tests = b.addRunArtifact(unit_tests);
        test_step.dependOn(&run_unit_tests.step);

        b.getInstallStep().dependOn(&run_unit_tests.step);
    }

    // const lib = b.addSharedLibrary(.{
    //     .name = "test_zon",
    //     .root_source_file = .{ .path = "src/root.zig" },
    //     .target = target,
    //     .optimize = optimize,
    // });
    // b.installArtifact(lib);

    // lib.linkSystemLibraryName("duckdb");

    // b.getInstallStep().dependOn()
}
