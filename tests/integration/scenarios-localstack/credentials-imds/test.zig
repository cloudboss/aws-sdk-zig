const std = @import("std");

const aws = @import("aws");
const ssm = @import("ssm");

var gpa: std.heap.DebugAllocator(.{}) = .init;

test "IMDS credential resolution does not leak on deinit" {
    const allocator = gpa.allocator();

    var env_map = try std.process.Environ.createMap(std.testing.environ, std.testing.allocator);
    defer env_map.deinit();
    var cfg = try aws.Config.load(allocator, std.testing.io, &env_map, .{});
    defer cfg.deinit();

    var client = ssm.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    _ = client.putParameter(
        arena.allocator(),
        .{
            .name = "/sdk-zig/cred-test-imds",
            .value = "test",
            .type = .string,
            .overwrite = true,
        },
        .{},
    ) catch {};

    _ = client.deleteParameter(
        arena.allocator(),
        .{ .name = "/sdk-zig/cred-test-imds" },
        .{},
    ) catch {};
}

test "zest.afterAll" {
    try std.testing.expect(gpa.deinit() == .ok);
}
