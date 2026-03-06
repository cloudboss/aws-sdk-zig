const std = @import("std");
const aws = @import("aws");

const apprunner = @import("apprunner");
const autoscaling = @import("autoscaling");
const batch = @import("batch");
const ecs = @import("ecs");
const eks = @import("eks");
const elasticbeanstalk = @import("elasticbeanstalk");
const emrserverless = @import("emrserverless");
const imagebuilder = @import("imagebuilder");
const lightsail = @import("lightsail");
const savingsplans = @import("savingsplans");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "autoscaling describeAutoScalingGroups" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = autoscaling.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeAutoScalingGroups(
        arena.allocator(),
        .{},
        .{},
    );
}

test "batch describeJobQueues" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = batch.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeJobQueues(
        arena.allocator(),
        .{},
        .{},
    );
}

test "apprunner listServices" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = apprunner.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listServices(
        arena.allocator(),
        .{},
        .{},
    );
}

test "ecs listClusters" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = ecs.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listClusters(
        arena.allocator(),
        .{},
        .{},
    );
}

test "eks listClusters" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = eks.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listClusters(
        arena.allocator(),
        .{},
        .{},
    );
}

test "lightsail getRegions" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = lightsail.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.getRegions(
        arena.allocator(),
        .{},
        .{},
    );
}

test "elasticbeanstalk describeApplications" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = elasticbeanstalk.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeApplications(
        arena.allocator(),
        .{},
        .{},
    );
}

test "imagebuilder listImages" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = imagebuilder.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listImages(
        arena.allocator(),
        .{},
        .{},
    );
}

test "savingsplans describeSavingsPlans" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = savingsplans.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.describeSavingsPlans(
        arena.allocator(),
        .{},
        .{},
    );
}

test "emrserverless listApplications" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = emrserverless.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listApplications(
        arena.allocator(),
        .{},
        .{},
    );
}
