const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BatchError = @import("batch_error.zig").BatchError;
const StreamKey = @import("stream_key.zig").StreamKey;

pub const BatchGetStreamKeyInput = struct {
    /// Array of ARNs, one per stream key.
    arns: []const []const u8,

    pub const json_field_names = .{
        .arns = "arns",
    };
};

pub const BatchGetStreamKeyOutput = struct {
    /// See
    /// [Access-Control-Allow-Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Access-Control-Allow-Origin) in the MDN Web Docs.
    access_control_allow_origin: ?[]const u8 = null,

    /// See
    /// [Access-Control-Expose-Headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Access-Control-Expose-Headers) in the MDN Web Docs.
    access_control_expose_headers: ?[]const u8 = null,

    /// See
    /// [Cache-Control](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Cache-Control) in the MDN Web Docs.
    cache_control: ?[]const u8 = null,

    /// See
    /// [Content-Security-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy) in the MDN Web Docs.
    content_security_policy: ?[]const u8 = null,

    errors: ?[]const BatchError = null,

    stream_keys: ?[]const StreamKey = null,

    /// See
    /// [Strict-Transport-Security](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Strict-Transport-Security) in the MDN Web Docs.
    strict_transport_security: ?[]const u8 = null,

    /// See
    /// [X-Content-Type-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Content-Type-Options) in the MDN Web Docs.
    x_content_type_options: ?[]const u8 = null,

    /// See
    /// [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/X-Frame-Options) in the MDN Web Docs.
    x_frame_options: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_control_allow_origin = "accessControlAllowOrigin",
        .access_control_expose_headers = "accessControlExposeHeaders",
        .cache_control = "cacheControl",
        .content_security_policy = "contentSecurityPolicy",
        .errors = "errors",
        .stream_keys = "streamKeys",
        .strict_transport_security = "strictTransportSecurity",
        .x_content_type_options = "xContentTypeOptions",
        .x_frame_options = "xFrameOptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetStreamKeyInput, options: CallOptions) !BatchGetStreamKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ivs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetStreamKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/BatchGetStreamKey";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"arns\":");
    try aws.json.writeValue(@TypeOf(input.arns), input.arns, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetStreamKeyOutput {
    var result: BatchGetStreamKeyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetStreamKeyOutput, body, allocator);
    }
    _ = status;
    if (headers.get("access-control-allow-origin")) |value| {
        result.access_control_allow_origin = try allocator.dupe(u8, value);
    }
    if (headers.get("access-control-expose-headers")) |value| {
        result.access_control_expose_headers = try allocator.dupe(u8, value);
    }
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (headers.get("content-security-policy")) |value| {
        result.content_security_policy = try allocator.dupe(u8, value);
    }
    if (headers.get("strict-transport-security")) |value| {
        result.strict_transport_security = try allocator.dupe(u8, value);
    }
    if (headers.get("x-content-type-options")) |value| {
        result.x_content_type_options = try allocator.dupe(u8, value);
    }
    if (headers.get("x-frame-options")) |value| {
        result.x_frame_options = try allocator.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelNotBroadcasting")) {
        return .{ .arena = arena, .kind = .{ .channel_not_broadcasting = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PendingVerification")) {
        return .{ .arena = arena, .kind = .{ .pending_verification = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailable")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StreamUnavailable")) {
        return .{ .arena = arena, .kind = .{ .stream_unavailable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
