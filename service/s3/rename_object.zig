const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Renames an existing object in a directory bucket that uses the S3 Express
/// One Zone storage class.
/// You can use `RenameObject` by specifying an existing object’s name as the
/// source and the new
/// name of the object as the destination within the same directory bucket.
///
/// **Note:**
///
/// `RenameObject` is only supported for objects stored in the S3 Express One
/// Zone storage
/// class.
///
/// To prevent overwriting an object, you can use the `If-None-Match`
/// conditional
/// header.
///
/// * **If-None-Match** - Renames the object only if an object
/// with the specified name does not already exist in the directory bucket. If
/// you don't want to
/// overwrite an existing object, you can add the `If-None-Match` conditional
/// header with the
/// value `‘*’` in the `RenameObject` request. Amazon S3 then returns a `412
/// Precondition Failed` error if the object with the specified name already
/// exists. For more
/// information, see [RFC 7232](https://datatracker.ietf.org/doc/rfc7232/).
///
/// **Permissions**
///
/// To grant access to the `RenameObject` operation on a directory bucket, we
/// recommend that you use the `CreateSession` operation for session-based
/// authorization.
/// Specifically, you grant the `s3express:CreateSession` permission to the
/// directory
/// bucket in a bucket policy or an IAM identity-based policy. Then, you make
/// the
/// `CreateSession` API call on the directory bucket to obtain a session token.
/// With the
/// session token in your request header, you can make API requests to this
/// operation. After the
/// session token expires, you make another `CreateSession` API call to generate
/// a new
/// session token for use. The Amazon Web Services CLI and SDKs will create and
/// manage your session including
/// refreshing the session token automatically to avoid service interruptions
/// when a session expires.
/// In your bucket policy, you can specify the `s3express:SessionMode` condition
/// key to
/// control who can create a `ReadWrite` or `ReadOnly` session. A
/// `ReadWrite` session is required for executing all the Zonal endpoint API
/// operations,
/// including `RenameObject`. For more information about authorization, see [
/// `CreateSession`
/// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateSession.html).
/// To learn more about Zonal endpoint API operations, see
/// [Authorizing Zonal endpoint API operations with
/// CreateSession](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-create-session.html) in the *Amazon S3 User
/// Guide*.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
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
    /// **Note:**
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const RenameObjectOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RenameObjectInput, options: Options) !RenameObjectOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: RenameObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.key);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "renameObject");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.client_token) |v| {
        try request.headers.put(alloc, "x-amz-client-token", v);
    }
    if (input.destination_if_match) |v| {
        try request.headers.put(alloc, "If-Match", v);
    }
    if (input.destination_if_modified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "If-Modified-Since", num_str);
        }
    }
    if (input.destination_if_none_match) |v| {
        try request.headers.put(alloc, "If-None-Match", v);
    }
    if (input.destination_if_unmodified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "If-Unmodified-Since", num_str);
        }
    }
    try request.headers.put(alloc, "x-amz-rename-source", input.rename_source);
    if (input.source_if_match) |v| {
        try request.headers.put(alloc, "x-amz-rename-source-if-match", v);
    }
    if (input.source_if_modified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-rename-source-if-modified-since", num_str);
        }
    }
    if (input.source_if_none_match) |v| {
        try request.headers.put(alloc, "x-amz-rename-source-if-none-match", v);
    }
    if (input.source_if_unmodified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-rename-source-if-unmodified-since", num_str);
        }
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RenameObjectOutput {
    _ = body;
    _ = status;
    _ = headers;
    const result: RenameObjectOutput = .{ .allocator = alloc };

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestId") orelse "";

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .access_denied = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .bucket_already_exists = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .bucket_already_owned_by_you = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .encryption_type_mismatch = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .idempotency_parameter_mismatch = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .invalid_object_state = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .invalid_request = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .invalid_write_offset = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .no_such_bucket = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .no_such_key = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .no_such_upload = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .not_found = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .object_already_in_active_tier_error = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .object_not_in_active_tier_error = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .too_many_parts = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendXmlEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            '&' => try buf.appendSlice(alloc, "&amp;"),
            '<' => try buf.appendSlice(alloc, "&lt;"),
            '>' => try buf.appendSlice(alloc, "&gt;"),
            else => try buf.append(alloc, c),
        }
    }
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
