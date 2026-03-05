const std = @import("std");
const aws = @import("aws");

const accessanalyzer = @import("accessanalyzer");
const acm = @import("acm");
const detective = @import("detective");
const guardduty = @import("guardduty");
const inspector2 = @import("inspector2");
const kms = @import("kms");
const macie2 = @import("macie2");
const securityhub = @import("securityhub");
const shield = @import("shield");
const wafv2 = @import("wafv2");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "kms listKeys" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = kms.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listKeys(
        arena.allocator(),
        .{},
        .{},
    );
}

test "acm listCertificates" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = acm.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listCertificates(
        arena.allocator(),
        .{},
        .{},
    );
}

test "wafv2 listWebAcLs" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = wafv2.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listWebAcLs(
        arena.allocator(),
        .{ .scope = .regional },
        .{},
    );
}

test "guardduty listDetectors" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = guardduty.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listDetectors(
        arena.allocator(),
        .{},
        .{},
    );
}

test "inspector2 listFindings" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = inspector2.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listFindings(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "accessanalyzer listAnalyzers" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = accessanalyzer.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listAnalyzers(
        arena.allocator(),
        .{},
        .{},
    );
}

test "detective listGraphs" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = detective.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = try client.listGraphs(
        arena.allocator(),
        .{},
        .{},
    );
}

test "macie2 listFindings" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = macie2.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.listFindings(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "securityhub describeHub" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = securityhub.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.describeHub(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "shield describeSubscription" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();
    var client = shield.Client.initWithOptions(
        gpa.allocator(),
        &shared_cfg.?,
        .{ .keep_alive = false },
    );
    defer client.deinit();
    _ = client.describeSubscription(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}
