const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // AWS Runtime Library module
    _ = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Unit tests
    const test_module = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const aws_tests = b.addTest(.{
        .root_module = test_module,
    });

    const run_aws_tests = b.addRunArtifact(aws_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_aws_tests.step);
}
