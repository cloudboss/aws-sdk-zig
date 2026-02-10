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

    var client = s3.Client.init(allocator, &cfg);
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

    // 3. GetObject -- verify the body matches what we put
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

        const body = result.body orelse return error.MissingBody;
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

    var client = s3.Client.init(allocator, &cfg);
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
