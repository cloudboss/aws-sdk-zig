const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const aws_sdk = b.dependency("aws_sdk", .{
        .target = target,
        .optimize = optimize,
    });

    const aws_module = b.createModule(.{
        .root_source_file = aws_sdk.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const s3_module = b.createModule(.{
        .root_source_file = aws_sdk.path("service/s3/root.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "aws", .module = aws_module },
        },
    });

    const exe = b.addExecutable(.{
        .name = "s3_list_buckets",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "aws", .module = aws_module },
                .{ .name = "s3", .module = s3_module },
            },
        }),
    });

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");

    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
}
