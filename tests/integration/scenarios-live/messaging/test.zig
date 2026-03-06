const std = @import("std");
const aws = @import("aws");

const connect = @import("connect");
const ivs = @import("ivs");
const mediaconvert = @import("mediaconvert");
const mediapackage = @import("mediapackage");
const pinpoint = @import("pinpoint");
const polly = @import("polly");
const ses = @import("ses");
const sesv2 = @import("sesv2");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_cfg: ?aws.Config = null;

test "zest.beforeAll" {
    shared_cfg = try aws.Config.load(gpa.allocator(), .{});
}

test "zest.afterAll" {
    if (shared_cfg) |*cfg| cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "ses listIdentities" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = ses.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listIdentities(
        arena.allocator(),
        .{},
        .{},
    );
}

test "sesv2 listEmailIdentities" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = sesv2.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listEmailIdentities(
        arena.allocator(),
        .{},
        .{},
    );
}

test "pinpoint getApps" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = pinpoint.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.getApps(
        arena.allocator(),
        .{},
        .{},
    );
}

test "connect listInstances" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = connect.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listInstances(
        arena.allocator(),
        .{},
        .{},
    );
}

test "mediaconvert listJobs" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = mediaconvert.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = client.listJobs(
        arena.allocator(),
        .{},
        .{},
    ) catch return;
}

test "mediapackage listChannels" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = mediapackage.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listChannels(
        arena.allocator(),
        .{},
        .{},
    );
}

test "ivs listChannels" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = ivs.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    _ = try client.listChannels(
        arena.allocator(),
        .{},
        .{},
    );
}

test "polly describeVoices" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    var client = polly.Client.init(std.testing.allocator, &shared_cfg.?);
    defer client.deinit();
    const result = try client.describeVoices(
        arena.allocator(),
        .{},
        .{},
    );
    try std.testing.expect(result.voices != null);
}
