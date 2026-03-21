const std = @import("std");
const aws = @import("aws");
const s3 = @import("s3");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: s3.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;
var shared_bucket_buf: [96]u8 = undefined;
var shared_bucket: []const u8 = "";

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    shared_cfg = try aws.Config.load(allocator, .{});
    errdefer shared_cfg.deinit();
    shared_client = s3.Client.init(allocator, &shared_cfg);
    errdefer shared_client.deinit();

    var rand_buf: [4]u8 = undefined;
    std.crypto.random.bytes(&rand_buf);
    const rand_suffix = std.mem.readInt(u32, &rand_buf, .little);

    shared_bucket = try std.fmt.bufPrint(
        &shared_bucket_buf,
        "sdk-zig-live-s3-{d}-{x}",
        .{ std.time.milliTimestamp(), rand_suffix },
    );

    var create_bucket_diagnostic: s3.ServiceError = undefined;
    _ = shared_client.createBucket(
        arena.allocator(),
        .{ .bucket = shared_bucket },
        .{ .diagnostic = &create_bucket_diagnostic },
    ) catch |err| {
        if (err == error.ServiceError) {
            defer create_bucket_diagnostic.deinit();
            std.debug.print(
                "createBucket ServiceError code={s} message={s}\n",
                .{
                    create_bucket_diagnostic.code(),
                    create_bucket_diagnostic.message(),
                },
            );
        }
        return err;
    };

    var put_bucket_tagging_diagnostic: s3.ServiceError = undefined;
    _ = shared_client.putBucketTagging(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .tagging = .{
                .tag_set = &.{
                    .{
                        .key = "aws-sdk-zig-test",
                        .value = "true",
                    },
                    .{
                        .key = "created-by",
                        .value = "integration-test",
                    },
                },
            },
        },
        .{ .diagnostic = &put_bucket_tagging_diagnostic },
    ) catch |err| {
        if (err == error.ServiceError) {
            defer put_bucket_tagging_diagnostic.deinit();
            std.debug.print(
                "putBucketTagging ServiceError code={s} message={s}\n",
                .{
                    put_bucket_tagging_diagnostic.code(),
                    put_bucket_tagging_diagnostic.message(),
                },
            );
        }
        return err;
    };

    _ = try shared_client.putObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "hello.txt",
            .body = "hello world",
        },
        .{},
    );
    _ = try shared_client.putObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "prefix-a/file.txt",
            .body = "a",
        },
        .{},
    );
    _ = try shared_client.putObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "prefix-b/file.txt",
            .body = "b",
        },
        .{},
    );

    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    const allocator = gpa.allocator();
    const cleanup_keys = [_][]const u8{
        "hello.txt",
        "prefix-a/file.txt",
        "prefix-b/file.txt",
        "put-test.txt",
        "hello-copy.txt",
        "delete-me.txt",
        "batch-a.txt",
        "batch-b.txt",
    };
    for (cleanup_keys) |key| {
        _ = shared_client.deleteObject(
            allocator,
            .{ .bucket = shared_bucket, .key = key },
            .{},
        ) catch {};
    }

    _ = shared_client.deleteBucket(allocator, .{ .bucket = shared_bucket }, .{}) catch {};

    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "putObject uploads content" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    _ = try shared_client.putObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "put-test.txt",
            .body = "put test content",
        },
        .{},
    );
}

test "getObject downloads content" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var result = try shared_client.getObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "hello.txt",
        },
        .{},
    );
    defer result.deinit();

    var streaming = result.body orelse
        return error.MissingBody;
    const body = try streaming.readAll(
        allocator,
        10 * 1024 * 1024,
    );
    defer allocator.free(body);
    try std.testing.expectEqualStrings("hello world", body);
}

test "headObject returns metadata" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.headObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "hello.txt",
        },
        .{},
    );

    const content_length = result.content_length orelse
        return error.MissingContentLength;
    try std.testing.expect(content_length > 0);
}

test "listObjectsV2 returns objects" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.listObjectsV2(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .prefix = "prefix-a/",
        },
        .{},
    );

    const contents = result.contents orelse
        return error.MissingContents;
    try std.testing.expect(contents.len > 0);
}

test "copyObject duplicates an object" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const copy_source = try std.fmt.allocPrint(
        arena.allocator(),
        "{s}/hello.txt",
        .{shared_bucket},
    );

    var diagnostic: s3.ServiceError = undefined;
    _ = shared_client.copyObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "hello-copy.txt",
            .copy_source = copy_source,
        },
        .{ .diagnostic = &diagnostic },
    ) catch |err| {
        if (err == error.ServiceError) {
            defer diagnostic.deinit();
            std.debug.print(
                "copyObject ServiceError code={s} message={s}\n",
                .{ diagnostic.code(), diagnostic.message() },
            );
        }
        return err;
    };

    var result = try shared_client.getObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "hello-copy.txt",
        },
        .{},
    );
    defer result.deinit();

    var streaming = result.body orelse
        return error.MissingBody;
    const body = try streaming.readAll(
        allocator,
        10 * 1024 * 1024,
    );
    defer allocator.free(body);
    try std.testing.expectEqualStrings("hello world", body);
}

test "deleteObject removes an object" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    _ = try shared_client.putObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "delete-me.txt",
            .body = "to be deleted",
        },
        .{},
    );

    _ = try shared_client.deleteObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "delete-me.txt",
        },
        .{},
    );
}

test "deleteObjects batch deletes" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    _ = try shared_client.putObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "batch-a.txt",
            .body = "a",
        },
        .{},
    );
    _ = try shared_client.putObject(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .key = "batch-b.txt",
            .body = "b",
        },
        .{},
    );

    const result = try shared_client.deleteObjects(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .delete = .{
                .objects = &.{
                    .{
                        .key = "batch-a.txt",
                        .e_tag = null,
                        .last_modified_time = null,
                        .size = null,
                        .version_id = null,
                    },
                    .{
                        .key = "batch-b.txt",
                        .e_tag = null,
                        .last_modified_time = null,
                        .size = null,
                        .version_id = null,
                    },
                },
                .quiet = null,
            },
        },
        .{},
    );

    const deleted = result.deleted orelse
        return error.MissingDeletedList;
    try std.testing.expectEqual(
        @as(usize, 2),
        deleted.len,
    );
}

test "putBucketTagging and getBucketTagging round-trip" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const tags = [_]s3.types.Tag{
        .{ .key = "env", .value = "test" },
        .{ .key = "project", .value = "sdk-zig" },
    };
    _ = try shared_client.putBucketTagging(
        arena.allocator(),
        .{
            .bucket = shared_bucket,
            .tagging = .{ .tag_set = &tags },
        },
        .{},
    );

    const result = try shared_client.getBucketTagging(
        arena.allocator(),
        .{ .bucket = shared_bucket },
        .{},
    );

    const tag_set = result.tag_set orelse
        return error.MissingTagSet;
    try std.testing.expect(tag_set.len >= 2);
}

test "listObjectsV2 paginator works" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var pag = shared_client.listObjectsV2Paginator(
        .{ .bucket = shared_bucket, .max_keys = 2 },
    );
    defer pag.deinit();

    var total_keys: usize = 0;
    var pages: usize = 0;
    while (!pag.done) {
        const page = try pag.next(
            arena.allocator(),
            .{},
        );

        if (page.contents) |contents| {
            total_keys += contents.len;
        }
        pages += 1;
    }

    try std.testing.expect(total_keys >= 3);
    try std.testing.expect(pages >= 2);
}
