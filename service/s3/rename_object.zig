const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const RenameObjectInput = struct {
    /// The bucket name of the directory bucket containing the object.
    ///
    /// You must use virtual-hosted-style requests in the format
    /// `Bucket-name.s3express-zone-id.region-code.amazonaws.com`. Path-style
    /// requests are not
    /// supported. Directory bucket names must be unique in the chosen Availability
    /// Zone. Bucket names must
    /// follow the format `bucket-base-name--zone-id--x-s3 ` (for example,
    /// `amzn-s3-demo-bucket--usw2-az1--x-s3`). For information about bucket naming
    /// restrictions, see
    /// [Directory bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-bucket-naming-rules.html) in the *Amazon S3 User Guide*.
    bucket: []const u8,

    /// A unique string with a max of 64 ASCII characters in the ASCII range of 33 -
    /// 126.
    ///
    /// `RenameObject` supports idempotency using a client token. To make an
    /// idempotent API request
    /// using `RenameObject`, specify a client token in the request. You should not
    /// reuse the same
    /// client token for other API requests. If you retry a request that completed
    /// successfully using the same
    /// client token and the same parameters, the retry succeeds without performing
    /// any further actions. If
    /// you retry a successful request using the same client token, but one or more
    /// of the parameters are
    /// different, the retry fails and an `IdempotentParameterMismatch` error is
    /// returned.
    client_token: ?[]const u8 = null,

    /// Renames the object only if the ETag (entity tag) value provided during the
    /// operation matches the
    /// ETag of the object in S3. The `If-Match` header field makes the request
    /// method conditional on
    /// ETags. If the ETag values do not match, the operation returns a `412
    /// Precondition Failed`
    /// error.
    ///
    /// Expects the ETag value as a string.
    destination_if_match: ?[]const u8 = null,

    /// Renames the object if the destination exists and if it has been modified
    /// since the specified
    /// time.
    destination_if_modified_since: ?i64 = null,

    /// Renames the object only if the destination does not already exist in the
    /// specified directory
    /// bucket. If the object does exist when you send a request with
    /// `If-None-Match:*`, the S3 API
    /// will return a `412 Precondition Failed` error, preventing an overwrite. The
    /// `If-None-Match` header prevents overwrites of existing data by validating
    /// that there's not
    /// an object with the same key name already in your directory bucket.
    ///
    /// Expects the `*` character (asterisk).
    destination_if_none_match: ?[]const u8 = null,

    /// Renames the object if it hasn't been modified since the specified time.
    destination_if_unmodified_since: ?i64 = null,

    /// Key name of the object to rename.
    key: []const u8,

    /// Specifies the source for the rename operation. The value must be URL
    /// encoded.
    rename_source: []const u8,

    /// Renames the object if the source exists and if its entity tag (ETag) matches
    /// the specified ETag.
    source_if_match: ?[]const u8 = null,

    /// Renames the object if the source exists and if it has been modified since
    /// the specified time.
    source_if_modified_since: ?i64 = null,

    /// Renames the object if the source exists and if its entity tag (ETag) is
    /// different than the specified
    /// ETag. If an asterisk (`*`) character is provided, the operation will fail
    /// and return a
    /// `412 Precondition Failed` error.
    source_if_none_match: ?[]const u8 = null,

    /// Renames the object if the source exists and hasn't been modified since the
    /// specified time.
    source_if_unmodified_since: ?i64 = null,
};

pub const RenameObjectOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RenameObjectInput, options: CallOptions) !RenameObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RenameObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.key);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "renameObject");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    if (input.client_token) |v| {
        try request.headers.put(allocator, "x-amz-client-token", v);
    }
    if (input.destination_if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }
    if (input.destination_if_modified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "If-Modified-Since", num_str);
        }
    }
    if (input.destination_if_none_match) |v| {
        try request.headers.put(allocator, "If-None-Match", v);
    }
    if (input.destination_if_unmodified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "If-Unmodified-Since", num_str);
        }
    }
    try request.headers.put(allocator, "x-amz-rename-source", input.rename_source);
    if (input.source_if_match) |v| {
        try request.headers.put(allocator, "x-amz-rename-source-if-match", v);
    }
    if (input.source_if_modified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "x-amz-rename-source-if-modified-since", num_str);
        }
    }
    if (input.source_if_none_match) |v| {
        try request.headers.put(allocator, "x-amz-rename-source-if-none-match", v);
    }
    if (input.source_if_unmodified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "x-amz-rename-source-if-unmodified-since", num_str);
        }
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RenameObjectOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RenameObjectOutput = .{};

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
