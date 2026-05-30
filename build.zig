const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const io = b.graph.io;

    const zest = b.dependency("zest", .{});

    // AWS Runtime Library module
    const aws_module = b.addModule("aws", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Auto-discover service modules from service/*/root.zig
    const services_path = "service";
    var service_modules = std.StringHashMap(*std.Build.Module).init(b.allocator);
    if (b.build_root.handle.openDir(io, services_path, .{ .iterate = true })) |dir| {
        var services_dir = dir;
        defer services_dir.close(io);
        var svc_iter = services_dir.iterate();
        while (svc_iter.next(io) catch null) |entry| {
            if (entry.kind != .directory) continue;
            // Dupe the name so the hash key outlives the directory iterator buffer
            const name = b.allocator.dupe(u8, entry.name) catch continue;
            const root_path = b.fmt("{s}/{s}/root.zig", .{ services_path, name });
            b.build_root.handle.access(io, root_path, .{}) catch continue;

            const svc_module = b.addModule(name, .{
                .root_source_file = b.path(root_path),
                .target = target,
                .optimize = optimize,
            });
            svc_module.addImport("aws", aws_module);
            service_modules.put(name, svc_module) catch {};
        }
    } else |_| {}

    // Reference extractor (hack/docgen): parses the generated services and
    // writes Markdown for the cloudboss MkDocs theme. `zig build docgen -- s3 sts`.
    const docgen_mod = b.createModule(.{
        .root_source_file = b.path("hack/docgen/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const docgen_exe = b.addExecutable(.{
        .name = "docgen",
        .root_module = docgen_mod,
    });
    const run_docgen = b.addRunArtifact(docgen_exe);
    if (b.args) |cli_args| run_docgen.addArgs(cli_args);
    const docgen_step = b.step("docgen", "Generate the Markdown API reference");
    docgen_step.dependOn(&run_docgen.step);

    const docgen_tests = b.addTest(.{
        .root_module = docgen_mod,
        .test_runner = .{
            .path = zest.path("src/root.zig"),
            .mode = .simple,
        },
    });
    const run_docgen_tests = b.addRunArtifact(docgen_tests);
    const docgen_test_step = b.step("docgen-test", "Run the docgen extractor unit tests");
    docgen_test_step.dependOn(&run_docgen_tests.step);

    // Unit tests
    const test_module = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const aws_tests = b.addTest(.{
        .root_module = test_module,
        .test_runner = .{
            .path = zest.path("src/root.zig"),
            .mode = .simple,
        },
    });

    const run_aws_tests = b.addRunArtifact(aws_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_aws_tests.step);
    test_step.dependOn(&run_docgen_tests.step);

    // Compile-check all service modules during test
    var check_iter = service_modules.iterator();
    while (check_iter.next()) |svc_entry| {
        const svc_check = b.addLibrary(.{
            .name = svc_entry.key_ptr.*,
            .root_module = svc_entry.value_ptr.*,
        });
        test_step.dependOn(&svc_check.step);
    }

    // Integration tests: auto-discover scenarios from tests/integration/scenarios-localstack/
    const scenarios_path = "tests/integration/scenarios-localstack";
    var scenarios_dir = b.build_root.handle.openDir(io, scenarios_path, .{ .iterate = true }) catch return;
    defer scenarios_dir.close(io);

    var iter = scenarios_dir.iterate();
    while (iter.next(io) catch null) |entry| {
        if (entry.kind != .directory) continue;

        const test_path = b.fmt("{s}/{s}/test.zig", .{ scenarios_path, entry.name });

        // Verify test.zig exists
        b.build_root.handle.access(io, test_path, .{}) catch continue;

        const integration_module = b.createModule(.{
            .root_source_file = b.path(test_path),
            .target = target,
            .optimize = optimize,
        });
        integration_module.addImport("aws", aws_module);

        // Add service module imports for this scenario
        var svc_mod_iter = service_modules.iterator();
        while (svc_mod_iter.next()) |svc_entry| {
            integration_module.addImport(svc_entry.key_ptr.*, svc_entry.value_ptr.*);
        }

        const integration_test = b.addTest(.{
            .root_module = integration_module,
            .test_runner = .{
                .path = zest.path("src/root.zig"),
                .mode = .simple,
            },
        });

        const run_integration = b.addRunArtifact(integration_test);
        const step_name = b.fmt("integration-test-localstack-{s}", .{entry.name});
        const step_desc = b.fmt("Run {s} localstack integration tests", .{entry.name});
        const step = b.step(step_name, step_desc);
        step.dependOn(&run_integration.step);
    }

    // Live tests: auto-discover scenarios from tests/integration/scenarios-live/
    const live_scenarios_path = "tests/integration/scenarios-live";
    var live_scenarios_dir = b.build_root.handle.openDir(
        io,
        live_scenarios_path,
        .{ .iterate = true },
    ) catch return;
    defer live_scenarios_dir.close(io);

    var live_iter = live_scenarios_dir.iterate();
    while (live_iter.next(io) catch null) |entry| {
        if (entry.kind != .directory) continue;

        const live_test_path = b.fmt(
            "{s}/{s}/test.zig",
            .{ live_scenarios_path, entry.name },
        );

        // Verify test.zig exists
        b.build_root.handle.access(io, live_test_path, .{}) catch continue;

        const live_module = b.createModule(.{
            .root_source_file = b.path(live_test_path),
            .target = target,
            .optimize = optimize,
        });
        live_module.addImport("aws", aws_module);

        // Add service module imports for this scenario
        var live_svc_mod_iter = service_modules.iterator();
        while (live_svc_mod_iter.next()) |svc_entry| {
            live_module.addImport(
                svc_entry.key_ptr.*,
                svc_entry.value_ptr.*,
            );
        }

        const live_test = b.addTest(.{
            .root_module = live_module,
            .test_runner = .{
                .path = zest.path("src/root.zig"),
                .mode = .simple,
            },
        });

        const run_live_test = b.addRunArtifact(live_test);
        const live_step_name = b.fmt("integration-test-live-{s}", .{entry.name});
        const live_step_desc = b.fmt(
            "Run {s} live integration tests",
            .{entry.name},
        );
        const live_step = b.step(live_step_name, live_step_desc);
        live_step.dependOn(&run_live_test.step);
    }
}
