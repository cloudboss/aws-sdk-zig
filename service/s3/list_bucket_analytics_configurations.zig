const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AnalyticsConfiguration = @import("analytics_configuration.zig").AnalyticsConfiguration;
const serde = @import("serde.zig");

pub const ListBucketAnalyticsConfigurationsInput = struct {
    /// The name of the bucket from which analytics configurations are retrieved.
    bucket: []const u8,

    /// The `ContinuationToken` that represents a placeholder from where this
    /// request should
    /// begin.
    continuation_token: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,
};

pub const ListBucketAnalyticsConfigurationsOutput = struct {
    /// The list of analytics configurations for a bucket.
    analytics_configuration_list: ?[]const AnalyticsConfiguration = null,

    /// The marker that is used as a starting point for this analytics configuration
    /// list response. This
    /// value is present if it was sent in the request.
    continuation_token: ?[]const u8 = null,

    /// Indicates whether the returned list of analytics configurations is complete.
    /// A value of true
    /// indicates that the list is not complete and the NextContinuationToken will
    /// be provided for a subsequent
    /// request.
    is_truncated: ?bool = null,

    /// `NextContinuationToken` is sent when `isTruncated` is true, which indicates
    /// that there are more analytics configurations to list. The next request must
    /// include this
    /// `NextContinuationToken`. The token is obfuscated and is not a usable value.
    next_continuation_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBucketAnalyticsConfigurationsInput, options: CallOptions) !ListBucketAnalyticsConfigurationsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListBucketAnalyticsConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "analytics&x-id=ListBucketAnalyticsConfigurations");
    query_has_prev = true;
    if (input.continuation_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "continuation-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBucketAnalyticsConfigurationsOutput {
    var result: ListBucketAnalyticsConfigurationsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var analytics_configuration_list_list: std.ArrayList(AnalyticsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnalyticsConfiguration")) {
                    try analytics_configuration_list_list.append(allocator, try serde.deserializeAnalyticsConfiguration(allocator, &reader));
                } else if (std.mem.eql(u8, e.local, "ContinuationToken")) {
                    result.continuation_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "NextContinuationToken")) {
                    result.next_continuation_token = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.analytics_configuration_list = if (analytics_configuration_list_list.items.len > 0) try analytics_configuration_list_list.toOwnedSlice(allocator) else null;
    _ = headers;

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
