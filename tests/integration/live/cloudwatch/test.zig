const std = @import("std");
const aws = @import("aws");
const cloudwatch = @import("cloudwatch");
const cloudwatchlogs = @import("cloudwatchlogs");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cw_client: ?cloudwatch.Client = null;
var shared_logs_client: ?cloudwatchlogs.Client = null;
var shared_cfg: ?aws.Config = null;
var shared_alarm_name_buf: [64]u8 = undefined;
var shared_alarm_name: []const u8 = "";
var shared_log_group_buf: [64]u8 = undefined;
var shared_log_group: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_cw_client = cloudwatch.Client.initWithOptions(
        allocator,
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    shared_logs_client = cloudwatchlogs.Client.initWithOptions(
        allocator,
        &shared_cfg.?,
        .{ .keep_alive = false },
    );

    const ts = std.time.timestamp();
    shared_alarm_name = try std.fmt.bufPrint(
        &shared_alarm_name_buf,
        "sdk-zig-live-alarm-{d}",
        .{ts},
    );
    shared_log_group = try std.fmt.bufPrint(
        &shared_log_group_buf,
        "/sdk-zig-live/lg-{d}",
        .{ts},
    );
}

test "zest.afterAll" {
    if (shared_cw_client) |*c| {
        defer c.deinit();
        if (shared_alarm_name.len > 0) {
            var arena = std.heap.ArenaAllocator.init(gpa.allocator());
            defer arena.deinit();
            _ = c.deleteAlarms(
                arena.allocator(),
                .{ .alarm_names = &.{shared_alarm_name} },
                .{},
            ) catch {};
        }
    }
    if (shared_logs_client) |*c| {
        defer c.deinit();
        if (shared_log_group.len > 0) {
            var arena = std.heap.ArenaAllocator.init(gpa.allocator());
            defer arena.deinit();
            _ = c.deleteLogGroup(
                arena.allocator(),
                .{ .log_group_name = shared_log_group },
                .{},
            ) catch {};
        }
    }
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "putMetricData publishes custom metric" {
    const client = &shared_cw_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try client.putMetricData(arena.allocator(), .{
        .namespace = "sdk-zig-live-test",
        .metric_data = &.{
            .{
                .metric_name = "TestMetric",
                .value = 1.0,
                .unit = .count,
            },
        },
    }, .{});
}

test "putMetricAlarm creates an alarm" {
    const client = &shared_cw_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try client.putMetricAlarm(arena.allocator(), .{
        .alarm_name = shared_alarm_name,
        .comparison_operator = .greater_than_threshold,
        .evaluation_periods = 1,
        .namespace = "sdk-zig-live-test",
        .metric_name = "TestMetric",
        .period = 60,
        .statistic = .sum,
        .threshold = 100.0,
        .tags = &.{
            .{
                .key = "aws-sdk-zig-test",
                .value = "true",
            },
            .{
                .key = "created-by",
                .value = "integration-test",
            },
        },
    }, .{});
}

test "describeAlarms includes created alarm" {
    const client = &shared_cw_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try client.describeAlarms(
        arena.allocator(),
        .{
            .alarm_name_prefix = "sdk-zig-live-alarm-",
        },
        .{},
    );

    const alarms = result.metric_alarms orelse
        return error.MissingMetricAlarms;
    var found = false;
    for (alarms) |alarm| {
        const name = alarm.alarm_name orelse continue;
        if (std.mem.eql(u8, name, shared_alarm_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "deleteAlarms removes alarm" {
    const client = &shared_cw_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try client.deleteAlarms(
        arena.allocator(),
        .{ .alarm_names = &.{shared_alarm_name} },
        .{},
    );

    const result = try client.describeAlarms(
        arena.allocator(),
        .{
            .alarm_names = &.{shared_alarm_name},
        },
        .{},
    );

    const alarms = result.metric_alarms;
    if (alarms) |a| {
        try std.testing.expectEqual(0, a.len);
    }
}

test "createLogGroup creates a group" {
    const client = &shared_logs_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try client.createLogGroup(arena.allocator(), .{
        .log_group_name = shared_log_group,
        .tags = &.{
            .{
                .key = "aws-sdk-zig-test",
                .value = "true",
            },
            .{
                .key = "created-by",
                .value = "integration-test",
            },
        },
    }, .{});
}

test "describeLogGroups includes created group" {
    const client = &shared_logs_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try client.describeLogGroups(
        arena.allocator(),
        .{
            .log_group_name_prefix = "/sdk-zig-live/lg-",
        },
        .{},
    );

    const groups = result.log_groups orelse
        return error.MissingLogGroups;
    var found = false;
    for (groups) |group| {
        const name = group.log_group_name orelse continue;
        if (std.mem.eql(u8, name, shared_log_group)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "deleteLogGroup removes the group" {
    const client = &shared_logs_client.?;
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    _ = try client.deleteLogGroup(
        arena.allocator(),
        .{ .log_group_name = shared_log_group },
        .{},
    );

    const result = try client.describeLogGroups(
        arena.allocator(),
        .{
            .log_group_name_prefix = shared_log_group,
        },
        .{},
    );

    const groups = result.log_groups;
    if (groups) |g| {
        var found = false;
        for (g) |group| {
            const name = group.log_group_name orelse
                continue;
            if (std.mem.eql(u8, name, shared_log_group)) {
                found = true;
                break;
            }
        }
        try std.testing.expect(!found);
    }
}
