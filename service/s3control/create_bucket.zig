const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BucketCannedACL = @import("bucket_canned_acl.zig").BucketCannedACL;
const CreateBucketConfiguration = @import("create_bucket_configuration.zig").CreateBucketConfiguration;
const serde = @import("serde.zig");

pub const CreateBucketInput = struct {
    /// The canned ACL to apply to the bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    acl: ?BucketCannedACL = null,

    /// The name of the bucket.
    bucket: []const u8,

    /// The configuration information for the bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    create_bucket_configuration: ?CreateBucketConfiguration = null,

    /// Allows grantee the read, write, read ACP, and write ACP permissions on the
    /// bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_full_control: ?[]const u8 = null,

    /// Allows grantee to list the objects in the bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_read: ?[]const u8 = null,

    /// Allows grantee to read the bucket ACL.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_read_acp: ?[]const u8 = null,

    /// Allows grantee to create, overwrite, and delete any object in the bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_write: ?[]const u8 = null,

    /// Allows grantee to write the ACL for the applicable bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_write_acp: ?[]const u8 = null,

    /// Specifies whether you want S3 Object Lock to be enabled for the new bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    object_lock_enabled_for_bucket: ?bool = null,

    /// The ID of the Outposts where the bucket is being created.
    ///
    /// This ID is required by Amazon S3 on Outposts buckets.
    outpost_id: ?[]const u8 = null,
};

const CreateBucketOutput = @import("create_bucket_result.zig").CreateBucketResult;

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBucketInput, options: Options) !CreateBucketOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3control");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3control", "S3 Control", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v20180820/bucket/");
    try path_buf.appendSlice(alloc, input.bucket);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = blk: {
        if (input.create_bucket_configuration) |payload| {
            var body_buf: std.ArrayList(u8) = .{};
            try body_buf.appendSlice(alloc, "<CreateBucketConfiguration xmlns=" ++ &[_]u8{0x22} ++ "http://awss3control.amazonaws.com/doc/2018-08-20/" ++ &[_]u8{0x22} ++ ">");
            try serde.serializeCreateBucketConfiguration(alloc, &body_buf, payload);
            try body_buf.appendSlice(alloc, "</CreateBucketConfiguration>");
            break :blk try body_buf.toOwnedSlice(alloc);
        }
        break :blk null;
    };

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.acl) |v| {
        try request.headers.put(alloc, "x-amz-acl", @tagName(v));
    }
    if (input.grant_full_control) |v| {
        try request.headers.put(alloc, "x-amz-grant-full-control", v);
    }
    if (input.grant_read) |v| {
        try request.headers.put(alloc, "x-amz-grant-read", v);
    }
    if (input.grant_read_acp) |v| {
        try request.headers.put(alloc, "x-amz-grant-read-acp", v);
    }
    if (input.grant_write) |v| {
        try request.headers.put(alloc, "x-amz-grant-write", v);
    }
    if (input.grant_write_acp) |v| {
        try request.headers.put(alloc, "x-amz-grant-write-acp", v);
    }
    if (input.object_lock_enabled_for_bucket) |v| {
        try request.headers.put(alloc, "x-amz-bucket-object-lock-enabled", if (v) "true" else "false");
    }
    if (input.outpost_id) |v| {
        try request.headers.put(alloc, "x-amz-outpost-id", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateBucketOutput {
    var result: CreateBucketOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BucketArn")) {
                    result.bucket_arn = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try alloc.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "JobStatusException")) {
        return .{ .arena = arena, .kind = .{ .job_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchPublicAccessBlockConfiguration")) {
        return .{ .arena = arena, .kind = .{ .no_such_public_access_block_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
