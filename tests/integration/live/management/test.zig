const std = @import("std");
const aws = @import("aws");

const cloudformation = @import("cloudformation");
const cloudtrail = @import("cloudtrail");
const configservice = @import("configservice");
const costexplorer = @import("costexplorer");
const health = @import("health");
const organizations = @import("organizations");
const resourcegroups = @import("resourcegroups");
const servicecatalog = @import("servicecatalog");
const ssoadmin = @import("ssoadmin");
const support = @import("support");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "cloudformation listStacks" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = cloudformation.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listStacks(arena.allocator(), .{}, .{});
}

test "configservice describeConfigRules" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = configservice.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.describeConfigRules(
        arena.allocator(),
        .{},
        .{},
    );
}

test "cloudtrail describeTrails" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = cloudtrail.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.describeTrails(
        arena.allocator(),
        .{},
        .{},
    );
}

test "organizations describeOrganization" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = organizations.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.describeOrganization(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "servicecatalog listPortfolios" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = servicecatalog.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listPortfolios(
        arena.allocator(),
        .{},
        .{},
    );
}

test "ssoadmin listInstances" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = ssoadmin.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listInstances(
        arena.allocator(),
        .{},
        .{},
    );
}

test "resourcegroups listGroups" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = resourcegroups.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listGroups(
        arena.allocator(),
        .{},
        .{},
    );
}

test "health describeEvents" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = health.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.describeEvents(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "support describeServices" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = support.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.describeServices(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "costexplorer getCostAndUsage" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = costexplorer.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.getCostAndUsage(
        arena.allocator(),
        .{
            .time_period = .{
                .start = "2024-01-01",
                .end = "2024-01-02",
            },
            .granularity = .daily,
            .metrics = &.{"UnblendedCost"},
        },
        .{},
    );
}
