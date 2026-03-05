const std = @import("std");
const aws = @import("aws");

const amplify = @import("amplify");
const appstream = @import("appstream");
const datasync = @import("datasync");
const dms = @import("dms");
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
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = amplify.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listApps(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "appstream describeFleets" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = appstream.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.describeFleets(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "workspaces describeWorkspaces" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = workspaces.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.describeWorkspaces(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "iot listThings" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = iot.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listThings(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "iotevents listInputs" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = iotevents.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listInputs(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "greengrass listGroups" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = greengrass.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listGroups(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "datasync listTasks" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = datasync.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listTasks(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "transfer listServers" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = transfer.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listServers(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "dms describeReplicationInstances" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = dms.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.describeReplicationInstances(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "lakeformation listResources" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = lakeformation.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listResources(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}
