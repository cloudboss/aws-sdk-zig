const std = @import("std");
const aws = @import("aws");

const backup = @import("backup");
const dax = @import("dax");
const docdb = @import("docdb");
const efs = @import("efs");
const elasticache = @import("elasticache");
const fsx = @import("fsx");
const memorydb = @import("memorydb");
const neptune = @import("neptune");
const rds = @import("rds");
const redshift = @import("redshift");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "efs describeFileSystems" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = efs.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeFileSystems(
        arena.allocator(),
        .{},
        .{},
    );
}

test "fsx describeFileSystems" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = fsx.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeFileSystems(
        arena.allocator(),
        .{},
        .{},
    );
}

test "backup listBackupVaults" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = backup.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listBackupVaults(
        arena.allocator(),
        .{},
        .{},
    );
}

test "rds describeDBInstances" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = rds.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeDbInstances(
        arena.allocator(),
        .{},
        .{},
    );
}

test "elasticache describeCacheClusters" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = elasticache.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeCacheClusters(
        arena.allocator(),
        .{},
        .{},
    );
}

test "redshift describeClusters" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = redshift.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeClusters(
        arena.allocator(),
        .{},
        .{},
    );
}

test "neptune describeDBClusters" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = neptune.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeDbClusters(
        arena.allocator(),
        .{},
        .{},
    );
}

test "docdb describeDBClusters" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = docdb.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeDbClusters(
        arena.allocator(),
        .{},
        .{},
    );
}

test "memorydb describeClusters" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = memorydb.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeClusters(
        arena.allocator(),
        .{},
        .{},
    );
}

test "dax describeClusters" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = dax.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeClusters(
        arena.allocator(),
        .{},
        .{},
    );
}
