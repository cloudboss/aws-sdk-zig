const std = @import("std");
const aws = @import("aws");

const amplify = @import("amplify");
const appstream = @import("appstream");
const datasync = @import("datasync");
const databasemigrationservice = @import("databasemigrationservice");
const greengrass = @import("greengrass");
const iot = @import("iot");
const iotevents = @import("iotevents");
const lakeformation = @import("lakeformation");
const transfer = @import("transfer");
const workspaces = @import("workspaces");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "amplify listApps" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = amplify.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.listApps(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "appstream describeFleets" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = appstream.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.describeFleets(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "workspaces describeWorkspaces" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = workspaces.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.describeWorkspaces(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "iot listThings" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = iot.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.listThings(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "iotevents listInputs" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = iotevents.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.listInputs(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "greengrass listGroups" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = greengrass.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.listGroups(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "datasync listTasks" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = datasync.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.listTasks(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "transfer listServers" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = transfer.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.listServers(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "dms describeReplicationInstances" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = databasemigrationservice.Client.init(
        std.testing.allocator,
        &shared_cfg.?,
    );
    defer client.deinit();
    _ = client.describeReplicationInstances(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "lakeformation listResources" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = lakeformation.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.listResources(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}
