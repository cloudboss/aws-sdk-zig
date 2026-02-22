const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Bucket = @import("bucket.zig").Bucket;
const Owner = @import("owner.zig").Owner;
const serde = @import("serde.zig");

pub const ListBucketsInput = struct {
    /// Limits the response to buckets that are located in the specified Amazon Web
    /// Services Region. The Amazon Web Services Region must
    /// be expressed according to the Amazon Web Services Region code, such as
    /// `us-west-2` for the US West (Oregon)
    /// Region. For a list of the valid values for all of the Amazon Web Services
    /// Regions, see [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region).
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ListBucketsOutput) void {
        self._arena.deinit();
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListBucketsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "x-id=ListBuckets");
    query_has_prev = true;
    if (input.bucket_region) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "bucket-region=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.continuation_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "continuation-token=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
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
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListBucketsOutput {
    var result: ListBucketsOutput = .{};
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
                if (std.mem.eql(u8, e.local, "Buckets")) {
                    result.buckets = try serde.deserializeBuckets(&reader, alloc, "Bucket");
                } else if (std.mem.eql(u8, e.local, "ContinuationToken")) {
                    result.continuation_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try serde.deserializeOwner(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .access_denied = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .bucket_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .bucket_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .encryption_type_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .idempotency_parameter_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .invalid_object_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .invalid_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .invalid_write_offset = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .no_such_bucket = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .no_such_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .no_such_upload = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .object_already_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .object_not_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .too_many_parts = .{
            .message = owned_message,
            .request_id = owned_request_id,
            ._allocator = alloc,
        } };
    }

    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
