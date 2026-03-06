const std = @import("std");
const aws = @import("aws");

const appconfig = @import("appconfig");
const appflow = @import("appflow");
const appsync = @import("appsync");
const eventbridge = @import("eventbridge");
const mq = @import("mq");
const pipes = @import("pipes");
const scheduler = @import("scheduler");
const schemas = @import("schemas");
const sfn = @import("sfn");
const swf = @import("swf");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "eventbridge listEventBuses" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = eventbridge.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listEventBuses(
        arena.allocator(),
        .{},
        .{},
    );
}

test "sfn listStateMachines" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = sfn.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listStateMachines(
        arena.allocator(),
        .{},
        .{},
    );
}

test "appsync listGraphqlApis" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = appsync.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listGraphqlApis(
        arena.allocator(),
        .{},
        .{},
    );
}

test "mq listBrokers" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = mq.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listBrokers(
        arena.allocator(),
        .{},
        .{},
    );
}

test "pipes listPipes" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = pipes.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listPipes(
        arena.allocator(),
        .{},
        .{},
    );
}

test "scheduler listSchedules" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = scheduler.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listSchedules(
        arena.allocator(),
        .{},
        .{},
    );
}

test "schemas listRegistries" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = schemas.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listRegistries(
        arena.allocator(),
        .{},
        .{},
    );
}

test "swf listDomains" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = swf.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listDomains(
        arena.allocator(),
        .{ .registration_status = .registered },
        .{},
    );
}

test "appflow listFlows" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = appflow.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listFlows(
        arena.allocator(),
        .{},
        .{},
    );
}

test "appconfig listApplications" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = appconfig.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listApplications(
        arena.allocator(),
        .{},
        .{},
    );
}
