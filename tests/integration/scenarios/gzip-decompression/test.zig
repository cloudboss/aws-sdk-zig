const std = @import("std");
const aws = @import("aws");
const ssm = @import("ssm");
const s3 = @import("s3");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_ssm: ssm.Client = undefined;
var shared_s3: s3.Client = undefined;
var shared_cfg: aws.Config = undefined;
var setup_done: bool = false;

const bucket_name = "sdk-zig-gzip-decomp";

// Large value that servers are likely to compress.
var large_value: [4096]u8 = undefined;

fn initLargeValue() void {
    const pattern = "The quick brown fox jumps over the lazy dog. ";
    var i: usize = 0;
    while (i < large_value.len) {
        const remaining = large_value.len - i;
        const copy_len = @min(pattern.len, remaining);
        @memcpy(large_value[i..][0..copy_len], pattern[0..copy_len]);
        i += copy_len;
    }
}

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    initLargeValue();

    shared_cfg = try aws.Config.load(allocator, .{});

    shared_ssm = ssm.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );

    shared_s3 = s3.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );

    {
        _ = try shared_ssm.putParameter(
            arena.allocator(),
            .{
                .name = "/sdk-zig/gzip-decomp",
                .value = &large_value,
                .type = .string,
                .overwrite = true,
            },
            .{},
        );
    }
    {
        _ = try shared_s3.createBucket(
            arena.allocator(),
            .{ .bucket = bucket_name },
            .{},
        );
    }
    {
        _ = try shared_s3.putObject(
            arena.allocator(),
            .{
                .bucket = bucket_name,
                .key = "large.txt",
                .body = &large_value,
            },
            .{},
        );
    }
    setup_done = true;
}

test "zest.afterAll" {
    if (!setup_done) {
        _ = gpa.deinit();
        return;
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    _ = shared_ssm.deleteParameter(
        arena.allocator(),
        .{ .name = "/sdk-zig/gzip-decomp" },
        .{},
    ) catch {};
    _ = shared_s3.deleteObject(
        arena.allocator(),
        .{ .bucket = bucket_name, .key = "large.txt" },
        .{},
    ) catch {};
    _ = shared_s3.deleteBucket(
        arena.allocator(),
        .{ .bucket = bucket_name },
        .{},
    ) catch {};
    shared_ssm.deinit();
    shared_s3.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "SSM GetParameter returns correct value through service client" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_ssm.getParameter(
        arena.allocator(),
        .{ .name = "/sdk-zig/gzip-decomp" },
        .{},
    );

    const param = result.parameter orelse return error.MissingParameter;
    const value = param.value orelse return error.MissingValue;
    try std.testing.expectEqualStrings(&large_value, value);
}

test "S3 GetObject returns correct value through service client" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var result = try shared_s3.getObject(
        arena.allocator(),
        .{ .bucket = bucket_name, .key = "large.txt" },
        .{},
    );
    defer result.deinit();

    var streaming_body = result.body orelse return error.MissingBody;
    const body = try streaming_body.readAll(
        allocator,
        10 * 1024 * 1024,
    );
    defer allocator.free(body);
    try std.testing.expectEqualStrings(&large_value, body);
}
