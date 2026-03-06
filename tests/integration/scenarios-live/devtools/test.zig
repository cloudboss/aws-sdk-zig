const std = @import("std");
const aws = @import("aws");

const codeartifact = @import("codeartifact");
const codebuild = @import("codebuild");
const codecommit = @import("codecommit");
const codedeploy = @import("codedeploy");
const codepipeline = @import("codepipeline");
const codestarnotifications = @import("codestarnotifications");
const xray = @import("xray");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "codebuild listProjects" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = codebuild.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listProjects(
        arena.allocator(),
        .{},
        .{},
    );
}

test "codepipeline listPipelines" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = codepipeline.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listPipelines(
        arena.allocator(),
        .{},
        .{},
    );
}

test "codecommit listRepositories" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = codecommit.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listRepositories(
        arena.allocator(),
        .{},
        .{},
    );
}

test "codedeploy listApplications" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = codedeploy.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listApplications(
        arena.allocator(),
        .{},
        .{},
    );
}

test "codeartifact listDomains" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = codeartifact.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listDomains(
        arena.allocator(),
        .{},
        .{},
    );
}

test "xray getTraceSummaries" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = xray.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.getTraceSummaries(
        arena.allocator(),
        .{
            .start_time = 0.0,
            .end_time = 1.0,
            .time_range_type = .TraceId,
        },
        .{},
    ) catch return;
}

test "codestarnotifications listTargets" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = codestarnotifications.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listTargets(
        arena.allocator(),
        .{},
        .{},
    );
}
