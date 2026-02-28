const std = @import("std");
const aws = @import("aws");
const s3 = @import("s3");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: s3.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = s3.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );
    {
        _ = try s3.create_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-shared" },
            .{},
        );
    }
    {
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = "sdk-zig-s3-shared",
                .key = "hello.txt",
                .body = "hello world",
            },
            .{},
        );
    }
    {
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = "sdk-zig-s3-shared",
                .key = "prefix-a/file.txt",
                .body = "a",
            },
            .{},
        );
    }
    {
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = "sdk-zig-s3-shared",
                .key = "prefix-b/file.txt",
                .body = "b",
            },
            .{},
        );
    }
    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const keys = [_][]const u8{
        "hello.txt",
        "prefix-a/file.txt",
        "prefix-b/file.txt",
        "put-test.txt",
        "delete-me.txt",
        "empty.txt",
        "hello-copy.txt",
        "content-type-test.txt",
        "special key (1).txt",
    };
    for (keys) |key| {
        _ = s3.delete_object.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-shared", .key = key },
            .{},
        ) catch continue;
    }
    {
        _ = try s3.delete_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-shared" },
            .{},
        );
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "CreateBucket returns successfully" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    {
        _ = try s3.create_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-create-test" },
            .{},
        );
    }
    {
        _ = try s3.delete_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-create-test" },
            .{},
        );
    }
}

test "PutObject stores object in bucket" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    _ = try s3.put_object.execute(
        &shared_client,
        arena.allocator(),
        .{
            .bucket = "sdk-zig-s3-shared",
            .key = "put-test.txt",
            .body = "put test content",
        },
        .{},
    );
}

test "GetObject retrieves stored object with correct body" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var result = try s3.get_object.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .key = "hello.txt" },
        .{},
    );
    defer result.deinit();

    var streaming_body = result.body orelse return error.MissingBody;
    const body = try streaming_body.readAll(allocator, 10 * 1024 * 1024);
    defer allocator.free(body);
    try std.testing.expectEqualStrings("hello world", body);
}

test "DeleteObject removes object from bucket" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    {
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = "sdk-zig-s3-shared",
                .key = "delete-me.txt",
                .body = "to be deleted",
            },
            .{},
        );
    }

    {
        _ = try s3.delete_object.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-shared", .key = "delete-me.txt" },
            .{},
        );
    }

    var diagnostic: s3.ServiceError = undefined;
    const result = s3.get_object.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .key = "delete-me.txt" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic.kind) {
        .no_such_key => {},
        else => {
            std.log.err("expected NoSuchKey, got: {s}", .{diagnostic.code()});
            return error.UnexpectedError;
        },
    }
}

test "DeleteBucket removes empty bucket" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    {
        _ = try s3.create_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-delete-test" },
            .{},
        );
    }
    {
        _ = try s3.delete_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-delete-test" },
            .{},
        );
    }
}

test "GetObject returns NoSuchKey for missing object" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    var diagnostic: s3.ServiceError = undefined;
    const result = s3.get_object.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .key = "nonexistent-key-12345" },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);
    defer diagnostic.deinit();

    switch (diagnostic.kind) {
        .no_such_key => {},
        else => {
            std.log.err("expected NoSuchKey, got: {s}", .{diagnostic.code()});
            return error.UnexpectedError;
        },
    }
}

test "ListObjectsV2 paginator collects all objects across pages" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const bucket_name = "sdk-zig-s3-paginator";
    const obj_count = 5;

    {
        _ = try s3.create_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = bucket_name },
            .{},
        );
    }

    var key_bufs: [obj_count][16]u8 = undefined;
    var keys: [obj_count][]const u8 = undefined;
    for (0..obj_count) |i| {
        keys[i] = std.fmt.bufPrint(&key_bufs[i], "obj-{d}", .{i + 1}) catch
            unreachable;
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = bucket_name, .key = keys[i], .body = "data" },
            .{},
        );
    }

    var pag = shared_client.listObjectsV2Paginator(
        .{ .bucket = bucket_name, .max_keys = 2 },
    );
    defer pag.deinit();

    var total_keys: usize = 0;
    var pages: usize = 0;
    while (!pag.done) {
        const output = try pag.next(arena.allocator(), .{});

        if (output.contents) |contents| {
            total_keys += contents.len;
        }
        pages += 1;
    }

    try std.testing.expectEqual(@as(usize, obj_count), total_keys);
    try std.testing.expect(pages >= 3);

    for (0..obj_count) |i| {
        _ = try s3.delete_object.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = bucket_name, .key = keys[i] },
            .{},
        );
    }
    {
        _ = try s3.delete_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = bucket_name },
            .{},
        );
    }
}

test "presigned GetObject URL retrieves object without signing" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const presigned_url = try shared_client.presignGetObject(
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .key = "hello.txt" },
        .{ .expires_seconds = 60 },
    );

    var http_client = std.http.Client{ .allocator = allocator };
    defer http_client.deinit();

    const uri = std.Uri.parse(presigned_url) catch
        return error.InvalidPresignedUrl;

    var req = http_client.request(.GET, uri, .{}) catch
        return error.ConnectionFailed;
    defer req.deinit();

    req.sendBodiless() catch return error.RequestFailed;

    var redirect_buf: [4096]u8 = undefined;
    var response = req.receiveHead(&redirect_buf) catch
        return error.RequestFailed;

    try std.testing.expect(response.head.status == .ok);

    var transfer_buf: [4096]u8 = undefined;
    const body_reader = response.reader(&transfer_buf);
    const body = body_reader.allocRemaining(
        allocator,
        std.Io.Limit.limited(1024 * 1024),
    ) catch return error.ReadFailed;
    defer allocator.free(body);

    try std.testing.expectEqualStrings("hello world", body);
}

test "waitUntilBucketExists succeeds after CreateBucket" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    {
        _ = try s3.create_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-waiter" },
            .{},
        );
    }

    try shared_client.waitUntilBucketExists(
        .{ .bucket = "sdk-zig-s3-waiter" },
    );

    {
        _ = try s3.delete_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = "sdk-zig-s3-waiter" },
            .{},
        );
    }
}

test "HeadObject returns metadata for existing object" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    {
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = "sdk-zig-s3-shared",
                .key = "content-type-test.txt",
                .body = "head object test content",
                .content_type = "text/plain",
            },
            .{},
        );
    }

    const result = try s3.head_object.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .key = "content-type-test.txt" },
        .{},
    );

    const content_length = result.content_length orelse
        return error.MissingContentLength;
    try std.testing.expect(content_length > 0);

    const content_type = result.content_type orelse
        return error.MissingContentType;
    try std.testing.expect(
        std.mem.startsWith(u8, content_type, "text/plain"),
    );
}

test "CopyObject duplicates object to new key" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    {
        _ = try s3.copy_object.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = "sdk-zig-s3-shared",
                .key = "hello-copy.txt",
                .copy_source = "sdk-zig-s3-shared/hello.txt",
            },
            .{},
        );
    }

    var result = try s3.get_object.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .key = "hello-copy.txt" },
        .{},
    );
    defer result.deinit();

    var streaming_body = result.body orelse return error.MissingBody;
    const body = try streaming_body.readAll(allocator, 10 * 1024 * 1024);
    defer allocator.free(body);
    try std.testing.expectEqualStrings("hello world", body);
}

test "DeleteObjects removes multiple objects in one call" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const bucket_name = "sdk-zig-s3-delete-objects";
    const keys = [_][]const u8{ "obj-a", "obj-b", "obj-c" };

    {
        _ = try s3.create_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = bucket_name },
            .{},
        );
    }

    for (keys) |key| {
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = bucket_name, .key = key, .body = "data" },
            .{},
        );
    }

    {
        const result = try s3.delete_objects.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = bucket_name,
                .delete = .{
                    .objects = &.{
                        .{
                            .key = "obj-a",
                            .e_tag = null,
                            .last_modified_time = null,
                            .size = null,
                            .version_id = null,
                        },
                        .{
                            .key = "obj-b",
                            .e_tag = null,
                            .last_modified_time = null,
                            .size = null,
                            .version_id = null,
                        },
                        .{
                            .key = "obj-c",
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
        try std.testing.expectEqual(@as(usize, 3), deleted.len);
    }

    {
        _ = try s3.delete_bucket.execute(
            &shared_client,
            arena.allocator(),
            .{ .bucket = bucket_name },
            .{},
        );
    }
}

test "PutObject round-trips special characters in key" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const object_key = "special key (1).txt";
    const object_body = "special key content";

    {
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = "sdk-zig-s3-shared",
                .key = object_key,
                .body = object_body,
            },
            .{},
        );
    }

    var result = try s3.get_object.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .key = object_key },
        .{},
    );
    defer result.deinit();

    var streaming_body = result.body orelse return error.MissingBody;
    const body = try streaming_body.readAll(allocator, 10 * 1024 * 1024);
    defer allocator.free(body);
    try std.testing.expectEqualStrings(object_body, body);
}

test "ListBuckets includes shared bucket" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const result = try s3.list_buckets.execute(&shared_client, arena.allocator(), .{}, .{});

    const buckets = result.buckets orelse return error.MissingBucketList;
    var found = false;
    for (buckets) |bucket| {
        if (bucket.name) |name| {
            if (std.mem.eql(u8, name, "sdk-zig-s3-shared")) {
                found = true;
                break;
            }
        }
    }
    try std.testing.expect(found);
}

test "PutObject with empty body stores zero-length object" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    {
        _ = try s3.put_object.execute(
            &shared_client,
            arena.allocator(),
            .{
                .bucket = "sdk-zig-s3-shared",
                .key = "empty.txt",
                .body = "",
            },
            .{},
        );
    }

    const result = try s3.head_object.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .key = "empty.txt" },
        .{},
    );

    const content_length = result.content_length orelse
        return error.MissingContentLength;
    try std.testing.expectEqual(@as(i64, 0), content_length);
}

test "ListObjectsV2 with prefix filters results" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const result = try s3.list_objects_v2.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .prefix = "prefix-a/" },
        .{},
    );

    const contents = result.contents orelse return error.MissingContents;
    try std.testing.expectEqual(@as(usize, 1), contents.len);
}

test "CreateBucket that already exists returns successfully" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    _ = try s3.create_bucket.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared" },
        .{},
    );
}

test "HeadObject returns error for missing object" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const result = s3.head_object.execute(
        &shared_client,
        arena.allocator(),
        .{
            .bucket = "sdk-zig-s3-shared",
            .key = "nonexistent-12345.txt",
        },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}

test "ListObjectsV2 returns empty for prefix with no objects" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const result = try s3.list_objects_v2.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .prefix = "no-match-xyz/" },
        .{},
    );

    if (result.contents) |contents| {
        try std.testing.expectEqual(@as(usize, 0), contents.len);
    }
}

test "ListObjectsV2 with max_keys limits result count" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const result = try s3.list_objects_v2.execute(
        &shared_client,
        arena.allocator(),
        .{ .bucket = "sdk-zig-s3-shared", .max_keys = 1 },
        .{},
    );

    if (result.contents) |contents| {
        try std.testing.expect(contents.len <= 1);
    }
}
