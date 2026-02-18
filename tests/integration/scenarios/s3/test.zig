const std = @import("std");
const aws = @import("aws");
const s3 = @import("s3");

test "S3 CRUD: CreateBucket, PutObject, GetObject, DeleteObject, DeleteBucket" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-integration-test";
    const object_key = "test-object.txt";
    const object_body = "Hello from aws-sdk-zig!";

    // 1. CreateBucket
    {
        var result = try s3.create_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }

    // 2. PutObject
    {
        var result = try s3.put_object.execute(
            &client,
            .{
                .bucket = bucket_name,
                .key = object_key,
                .body = object_body,
            },
            .{},
        );
        defer result.deinit();
    }

    // 3. GetObject -- verify the streaming body matches what we put
    {
        var result = try s3.get_object.execute(
            &client,
            .{
                .bucket = bucket_name,
                .key = object_key,
            },
            .{},
        );
        defer result.deinit();

        const body = try result.body.readAll(allocator, 10 * 1024 * 1024);
        defer allocator.free(body);
        try std.testing.expectEqualStrings(object_body, body);
    }

    // 4. DeleteObject
    {
        var result = try s3.delete_object.execute(
            &client,
            .{
                .bucket = bucket_name,
                .key = object_key,
            },
            .{},
        );
        defer result.deinit();
    }

    // 5. DeleteBucket
    {
        var result = try s3.delete_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }
}

test "GetObject returns NoSuchKey for missing object" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-error-test";

    // Create bucket first
    {
        var result = try s3.create_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }

    // Try to get a nonexistent object
    var diagnostic: s3.ServiceError = undefined;
    const result = s3.get_object.execute(
        &client,
        .{
            .bucket = bucket_name,
            .key = "nonexistent-key-12345",
        },
        .{ .diagnostic = &diagnostic },
    );

    try std.testing.expectError(error.ServiceError, result);

    switch (diagnostic) {
        .no_such_key => |e| {
            _ = e;
            // Successfully parsed the NoSuchKey error from S3 XML error response
        },
        else => {
            std.debug.print("Expected NoSuchKey, got: {s}\n", .{diagnostic.code()});
            return error.UnexpectedError;
        },
    }

    // Clean up
    {
        var del_result = try s3.delete_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer del_result.deinit();
    }
}

test "ListObjectsV2 paginator collects all objects across pages" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-paginator-test";
    const obj_count = 5;

    // Create bucket
    {
        var result = try s3.create_bucket.execute(&client, .{ .bucket = bucket_name }, .{});
        defer result.deinit();
    }

    // Put 5 objects with distinct keys
    var key_bufs: [obj_count][16]u8 = undefined;
    var keys: [obj_count][]const u8 = undefined;
    for (0..obj_count) |i| {
        keys[i] = std.fmt.bufPrint(&key_bufs[i], "obj-{d}", .{i + 1}) catch unreachable;
        var result = try s3.put_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = keys[i], .body = "data" },
            .{},
        );
        defer result.deinit();
    }

    // Paginate with max_keys=2
    var pag = client.listObjectsV2Paginator(.{ .bucket = bucket_name, .max_keys = 2 });
    defer pag.deinit();

    var total_keys: usize = 0;
    var pages: usize = 0;
    while (!pag.done) {
        var output = try pag.next(.{});
        defer output.deinit();

        if (output.contents) |contents| {
            total_keys += contents.len;
        }
        pages += 1;
    }

    try std.testing.expectEqual(@as(usize, obj_count), total_keys);
    try std.testing.expect(pages >= 3); // 5 objects / 2 per page = at least 3 pages

    // Clean up objects
    for (0..obj_count) |i| {
        var result = try s3.delete_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = keys[i] },
            .{},
        );
        defer result.deinit();
    }

    // Delete bucket
    {
        var result = try s3.delete_bucket.execute(&client, .{ .bucket = bucket_name }, .{});
        defer result.deinit();
    }
}

test "presigned GetObject URL retrieves object without signing" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-presign-test";
    const object_key = "presign-test.txt";
    const object_body = "presigned content here";

    // Create bucket
    {
        var result = try s3.create_bucket.execute(&client, .{ .bucket = bucket_name }, .{});
        defer result.deinit();
    }

    // PutObject
    {
        var result = try s3.put_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = object_key, .body = object_body },
            .{},
        );
        defer result.deinit();
    }

    // Generate presigned URL
    const presigned_url = try client.presignGetObject(
        .{ .bucket = bucket_name, .key = object_key },
        .{ .expires_seconds = 60 },
    );
    defer allocator.free(presigned_url);

    // Fetch via plain HTTP (no AWS signing)
    var http_client = std.http.Client{ .allocator = allocator };
    defer http_client.deinit();

    const uri = std.Uri.parse(presigned_url) catch return error.InvalidPresignedUrl;

    var req = http_client.request(.GET, uri, .{}) catch return error.ConnectionFailed;
    defer req.deinit();

    req.sendBodiless() catch return error.RequestFailed;

    var redirect_buf: [4096]u8 = undefined;
    var response = req.receiveHead(&redirect_buf) catch return error.RequestFailed;

    try std.testing.expect(response.head.status == .ok);

    var transfer_buf: [4096]u8 = undefined;
    const body_reader = response.reader(&transfer_buf);
    const body = body_reader.allocRemaining(allocator, std.Io.Limit.limited(1024 * 1024)) catch return error.ReadFailed;
    defer allocator.free(body);

    try std.testing.expectEqualStrings(object_body, body);

    // Clean up
    {
        var result = try s3.delete_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = object_key },
            .{},
        );
        defer result.deinit();
    }
    {
        var result = try s3.delete_bucket.execute(&client, .{ .bucket = bucket_name }, .{});
        defer result.deinit();
    }
}

test "waitUntilBucketExists succeeds after CreateBucket" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-waiter-test";

    // Create bucket
    {
        var result = try s3.create_bucket.execute(&client, .{ .bucket = bucket_name }, .{});
        defer result.deinit();
    }

    // Wait should succeed immediately
    try client.waitUntilBucketExists(.{ .bucket = bucket_name });

    // Clean up
    {
        var result = try s3.delete_bucket.execute(&client, .{ .bucket = bucket_name }, .{});
        defer result.deinit();
    }
}

test "HeadObject returns metadata for existing object" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-s3-head-object";
    const object_key = "test-object.txt";
    const object_body = "head object test content";

    // CreateBucket
    {
        var result = try s3.create_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }

    // PutObject with content-type
    {
        var result = try s3.put_object.execute(
            &client,
            .{
                .bucket = bucket_name,
                .key = object_key,
                .body = object_body,
                .content_type = "text/plain",
            },
            .{},
        );
        defer result.deinit();
    }

    // HeadObject -- verify metadata
    {
        var result = try s3.head_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = object_key },
            .{},
        );
        defer result.deinit();

        const content_length = result.content_length orelse
            return error.MissingContentLength;
        try std.testing.expect(content_length > 0);

        const content_type = result.content_type orelse
            return error.MissingContentType;
        try std.testing.expect(
            std.mem.startsWith(u8, content_type, "text/plain"),
        );
    }

    // Cleanup
    {
        var result = try s3.delete_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = object_key },
            .{},
        );
        defer result.deinit();
    }
    {
        var result = try s3.delete_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }
}

test "CopyObject duplicates object to new key" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-s3-copy-object";
    const source_key = "source.txt";
    const dest_key = "copy.txt";
    const object_body = "original content";

    // CreateBucket
    {
        var result = try s3.create_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }

    // PutObject -- source
    {
        var result = try s3.put_object.execute(
            &client,
            .{
                .bucket = bucket_name,
                .key = source_key,
                .body = object_body,
            },
            .{},
        );
        defer result.deinit();
    }

    // CopyObject
    {
        var result = try s3.copy_object.execute(
            &client,
            .{
                .bucket = bucket_name,
                .key = dest_key,
                .copy_source = bucket_name ++ "/" ++ source_key,
            },
            .{},
        );
        defer result.deinit();
    }

    // GetObject on copy -- verify body matches original
    {
        var result = try s3.get_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = dest_key },
            .{},
        );
        defer result.deinit();

        const body = try result.body.readAll(allocator, 10 * 1024 * 1024);
        defer allocator.free(body);
        try std.testing.expectEqualStrings(object_body, body);
    }

    // Cleanup -- delete both keys then bucket
    {
        var result = try s3.delete_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = source_key },
            .{},
        );
        defer result.deinit();
    }
    {
        var result = try s3.delete_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = dest_key },
            .{},
        );
        defer result.deinit();
    }
    {
        var result = try s3.delete_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }
}

test "DeleteObjects removes multiple objects in one call" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-s3-delete-objects";
    const keys = [_][]const u8{ "obj-a", "obj-b", "obj-c" };

    // CreateBucket
    {
        var result = try s3.create_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }

    // PutObject for each key
    for (keys) |key| {
        var result = try s3.put_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = key, .body = "data" },
            .{},
        );
        defer result.deinit();
    }

    // DeleteObjects -- batch delete all 3
    {
        var result = try s3.delete_objects.execute(
            &client,
            .{
                .bucket = bucket_name,
                .delete = .{
                    .objects = &.{
                        .{ .key = "obj-a", .e_tag = null, .last_modified_time = null, .size = null, .version_id = null },
                        .{ .key = "obj-b", .e_tag = null, .last_modified_time = null, .size = null, .version_id = null },
                        .{ .key = "obj-c", .e_tag = null, .last_modified_time = null, .size = null, .version_id = null },
                    },
                    .quiet = null,
                },
            },
            .{},
        );
        defer result.deinit();

        const deleted = result.deleted orelse
            return error.MissingDeletedList;
        try std.testing.expectEqual(@as(usize, 3), deleted.len);
    }

    // Cleanup -- bucket only (objects already deleted)
    {
        var result = try s3.delete_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }
}

test "PutObject and GetObject with special characters in key" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = s3.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const bucket_name = "sdk-zig-s3-special-key";
    const object_key = "path/to/my file (1).txt";
    const object_body = "special key content";

    // CreateBucket
    {
        var result = try s3.create_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }

    // PutObject with special-character key
    {
        var result = try s3.put_object.execute(
            &client,
            .{
                .bucket = bucket_name,
                .key = object_key,
                .body = object_body,
            },
            .{},
        );
        defer result.deinit();
    }

    // GetObject -- verify round-trip with special characters
    {
        var result = try s3.get_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = object_key },
            .{},
        );
        defer result.deinit();

        const body = try result.body.readAll(allocator, 10 * 1024 * 1024);
        defer allocator.free(body);
        try std.testing.expectEqualStrings(object_body, body);
    }

    // Cleanup
    {
        var result = try s3.delete_object.execute(
            &client,
            .{ .bucket = bucket_name, .key = object_key },
            .{},
        );
        defer result.deinit();
    }
    {
        var result = try s3.delete_bucket.execute(
            &client,
            .{ .bucket = bucket_name },
            .{},
        );
        defer result.deinit();
    }
}
