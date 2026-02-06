const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // AWS Runtime Library module
    const aws_module = b.createModule(.{
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

    // Integration tests: auto-discover scenarios from tests/integration/scenarios/
    const scenarios_path = "tests/integration/scenarios";
    var scenarios_dir = std.fs.cwd().openDir(scenarios_path, .{ .iterate = true }) catch return;
    defer scenarios_dir.close();

    var iter = scenarios_dir.iterate();
    while (iter.next() catch null) |entry| {
        if (entry.kind != .directory) continue;

        const test_path = b.fmt("{s}/{s}/test.zig", .{ scenarios_path, entry.name });

        // Verify test.zig exists
        std.fs.cwd().access(test_path, .{}) catch continue;

        const integration_module = b.createModule(.{
            .root_source_file = b.path(test_path),
            .target = target,
            .optimize = optimize,
        });
        integration_module.addImport("aws", aws_module);

        const integration_test = b.addTest(.{
            .root_module = integration_module,
        });

        const run_integration = b.addRunArtifact(integration_test);
        const step_name = b.fmt("integration-test-{s}", .{entry.name});
        const step_desc = b.fmt("Run {s} integration tests", .{entry.name});
        const step = b.step(step_name, step_desc);
        step.dependOn(&run_integration.step);
    }
}
