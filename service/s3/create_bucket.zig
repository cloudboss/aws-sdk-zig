const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BucketCannedACL = @import("bucket_canned_acl.zig").BucketCannedACL;
const CreateBucketConfiguration = @import("create_bucket_configuration.zig").CreateBucketConfiguration;
const ObjectOwnership = @import("object_ownership.zig").ObjectOwnership;
const serde = @import("serde.zig");

pub const CreateBucketInput = struct {
    /// The canned ACL to apply to the bucket.
    ///
    /// This functionality is not supported for directory buckets.
    acl: ?BucketCannedACL = null,

    /// The name of the bucket to create.
    ///
    /// **General purpose buckets** - For information about bucket naming
    /// restrictions, see [Bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html) in the *Amazon S3 User Guide*.
    ///
    /// **Directory buckets ** - When you use this operation with a directory
    /// bucket, you must use path-style requests in the format
    /// `https://s3express-control.*region-code*.amazonaws.com/*bucket-name*
    /// `. Virtual-hosted-style requests aren't supported. Directory bucket names
    /// must be unique in the chosen Zone (Availability Zone or Local Zone). Bucket
    /// names must also follow the format `
    /// *bucket-base-name*--*zone-id*--x-s3` (for example, `
    /// *DOC-EXAMPLE-BUCKET*--*usw2-az1*--x-s3`). For information about bucket
    /// naming restrictions, see [Directory bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-bucket-naming-rules.html) in the *Amazon S3 User Guide*
    bucket: []const u8,

    /// The configuration information for the bucket.
    create_bucket_configuration: ?CreateBucketConfiguration = null,

    /// Allows grantee the read, write, read ACP, and write ACP permissions on the
    /// bucket.
    ///
    /// This functionality is not supported for directory buckets.
    grant_full_control: ?[]const u8 = null,

    /// Allows grantee to list the objects in the bucket.
    ///
    /// This functionality is not supported for directory buckets.
    grant_read: ?[]const u8 = null,

    /// Allows grantee to read the bucket ACL.
    ///
    /// This functionality is not supported for directory buckets.
    grant_read_acp: ?[]const u8 = null,

    /// Allows grantee to create new objects in the bucket.
    ///
    /// For the bucket and object owners of existing objects, also allows deletions
    /// and overwrites of those
    /// objects.
    ///
    /// This functionality is not supported for directory buckets.
    grant_write: ?[]const u8 = null,

    /// Allows grantee to write the ACL for the applicable bucket.
    ///
    /// This functionality is not supported for directory buckets.
    grant_write_acp: ?[]const u8 = null,

    /// Specifies whether you want S3 Object Lock to be enabled for the new bucket.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_enabled_for_bucket: ?bool = null,

    object_ownership: ?ObjectOwnership = null,
};

pub const CreateBucketOutput = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket. ARNs uniquely identify
    /// Amazon Web Services resources across all
    /// of Amazon Web Services.
    ///
    /// This parameter is only supported for S3 directory buckets. For more
    /// information, see [Using tags with
    /// directory
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-tagging.html).
    bucket_arn: ?[]const u8 = null,

    /// A forward slash followed by the name of the bucket.
    location: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateBucketOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateBucketInput, options: Options) !CreateBucketOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = blk: {
        if (input.create_bucket_configuration) |payload| {
            var body_buf: std.ArrayList(u8) = .{};
            try body_buf.appendSlice(alloc, "<CreateBucketConfiguration xmlns=" ++ &[_]u8{0x22} ++ "http://s3.amazonaws.com/doc/2006-03-01/" ++ &[_]u8{0x22} ++ ">");
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
    if (input.object_ownership) |v| {
        try request.headers.put(alloc, "x-amz-object-ownership", @tagName(v));
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateBucketOutput {
    var result: CreateBucketOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-bucket-arn")) |value| {
        result.bucket_arn = try alloc.dupe(u8, value);
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

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .arena = arena, .kind = .{ .access_denied = .{
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
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .arena = arena, .kind = .{ .encryption_type_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .arena = arena, .kind = .{ .idempotency_parameter_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .arena = arena, .kind = .{ .invalid_object_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .arena = arena, .kind = .{ .invalid_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .arena = arena, .kind = .{ .invalid_write_offset = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .arena = arena, .kind = .{ .no_such_bucket = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .arena = arena, .kind = .{ .no_such_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .arena = arena, .kind = .{ .no_such_upload = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .arena = arena, .kind = .{ .not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .arena = arena, .kind = .{ .object_already_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .arena = arena, .kind = .{ .object_not_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .arena = arena, .kind = .{ .too_many_parts = .{
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
