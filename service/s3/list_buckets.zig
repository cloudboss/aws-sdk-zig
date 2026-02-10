const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Bucket = @import("bucket.zig").Bucket;
const Owner = @import("owner.zig").Owner;

/// **Note:**
///
/// This operation is not supported for directory buckets.
///
/// Returns a list of all buckets owned by the authenticated sender of the
/// request. To grant IAM
/// permission to use this operation, you must add the `s3:ListAllMyBuckets`
/// policy action.
///
/// For information about Amazon S3 buckets, see [Creating, configuring, and
/// working with Amazon S3
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-buckets-s3.html).
///
/// **Important:**
///
/// We strongly recommend using only paginated `ListBuckets` requests.
/// Unpaginated
/// `ListBuckets` requests are only supported for Amazon Web Services accounts
/// set to the default general
/// purpose bucket quota of 10,000. If you have an approved general purpose
/// bucket quota above 10,000, you
/// must send paginated `ListBuckets` requests to list your account’s buckets.
/// All unpaginated
/// `ListBuckets` requests will be rejected for Amazon Web Services accounts
/// with a general purpose bucket
/// quota greater than 10,000.
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const ListBucketsInput = struct {
    /// Limits the response to buckets that are located in the specified Amazon Web
    /// Services Region. The Amazon Web Services Region must
    /// be expressed according to the Amazon Web Services Region code, such as
    /// `us-west-2` for the US West (Oregon)
    /// Region. For a list of the valid values for all of the Amazon Web Services
    /// Regions, see [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region).
    ///
    /// **Note:**
    ///
    /// Requests made to a Regional endpoint that is different from the
    /// `bucket-region`
    /// parameter are not supported. For example, if you want to limit the response
    /// to your buckets in Region
    /// `us-west-2`, the request must be made to an endpoint in Region
    /// `us-west-2`.
    bucket_region: ?[]const u8 = null,

    /// `ContinuationToken` indicates to Amazon S3 that the list is being continued
    /// on this bucket
    /// with a token. `ContinuationToken` is obfuscated and is not a real key. You
    /// can use this
    /// `ContinuationToken` for pagination of the list results.
    ///
    /// Length Constraints: Minimum length of 0. Maximum length of 1024.
    ///
    /// Required: No.
    ///
    /// **Note:**
    ///
    /// If you specify the `bucket-region`, `prefix`, or
    /// `continuation-token` query parameters without using `max-buckets` to set the
    /// maximum number of buckets returned in the response, Amazon S3 applies a
    /// default page size of 10,000 and
    /// provides a continuation token if there are more buckets.
    continuation_token: ?[]const u8 = null,

    /// Maximum number of buckets to be returned in response. When the number is
    /// more than the count of
    /// buckets that are owned by an Amazon Web Services account, return all the
    /// buckets in response.
    max_buckets: ?i32 = null,

    /// Limits the response to bucket names that begin with the specified bucket
    /// name prefix.
    prefix: ?[]const u8 = null,
};

pub const ListBucketsOutput = struct {
    /// The list of buckets owned by the requester.
    buckets: ?[]const Bucket = null,

    /// `ContinuationToken` is included in the response when there are more buckets
    /// that can be
    /// listed with pagination. The next `ListBuckets` request to Amazon S3 can be
    /// continued with this
    /// `ContinuationToken`. `ContinuationToken` is obfuscated and is not a real
    /// bucket.
    continuation_token: ?[]const u8 = null,

    /// The owner of the buckets listed.
    owner: ?Owner = null,

    /// If `Prefix` was sent with the request, it is included in the response.
    ///
    /// All bucket names in the response begin with the specified bucket name
    /// prefix.
    prefix: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ListBucketsOutput) void {
        if (self.continuation_token) |v| {
            self.allocator.free(v);
        }
        if (self.prefix) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ListBucketsInput, options: Options) !ListBucketsOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListBucketsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    const path = "/";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "x-id=ListBuckets");
    query_has_prev = true;
    if (input.bucket_region) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "bucket-region=");
        try appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.continuation_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "continuation-token=");
        try appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_buckets) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "max-buckets=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "prefix=");
        try appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ListBucketsOutput {
    var result: ListBucketsOutput = .{ .allocator = alloc };
    _ = status;
    if (findElement(body, "ContinuationToken")) |content| {
        result.continuation_token = try alloc.dupe(u8, content);
    }
    if (findElement(body, "Prefix")) |content| {
        result.prefix = try alloc.dupe(u8, content);
    }

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
