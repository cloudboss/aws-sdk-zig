const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BrowserExtension = @import("browser_extension.zig").BrowserExtension;
const BrowserProfileConfiguration = @import("browser_profile_configuration.zig").BrowserProfileConfiguration;
const ViewPort = @import("view_port.zig").ViewPort;
const BrowserSessionStream = @import("browser_session_stream.zig").BrowserSessionStream;

pub const StartBrowserSessionInput = struct {
    /// The unique identifier of the browser to use for this session. This
    /// identifier specifies which browser environment to initialize for the
    /// session.
    browser_identifier: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock AgentCore ignores the request, but does not return an error. This
    /// parameter helps prevent the creation of duplicate sessions if there are
    /// temporary network issues.
    client_token: ?[]const u8 = null,

    /// A list of browser extensions to load into the browser session.
    extensions: ?[]const BrowserExtension = null,

    /// The name of the browser session. This name helps you identify and manage the
    /// session. The name does not need to be unique.
    name: ?[]const u8 = null,

    /// The browser profile configuration to use for this session. A browser profile
    /// contains persistent data such as cookies and local storage that can be
    /// reused across multiple browser sessions. If specified, the session
    /// initializes with the profile's stored data, enabling continuity for tasks
    /// that require authentication or personalized settings.
    profile_configuration: ?BrowserProfileConfiguration = null,

    /// The time in seconds after which the session automatically terminates if
    /// there is no activity. The default value is 3600 seconds (1 hour). The
    /// minimum allowed value is 60 seconds, and the maximum allowed value is 28800
    /// seconds (8 hours).
    session_timeout_seconds: ?i32 = null,

    /// The trace identifier for request tracking.
    trace_id: ?[]const u8 = null,

    /// The parent trace information for distributed tracing.
    trace_parent: ?[]const u8 = null,

    /// The dimensions of the browser viewport for this session. This determines the
    /// visible area of the web content and affects how web pages are rendered. If
    /// not specified, Amazon Bedrock AgentCore uses a default viewport size.
    view_port: ?ViewPort = null,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .client_token = "clientToken",
        .extensions = "extensions",
        .name = "name",
        .profile_configuration = "profileConfiguration",
        .session_timeout_seconds = "sessionTimeoutSeconds",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
        .view_port = "viewPort",
    };
};

pub const StartBrowserSessionOutput = struct {
    /// The identifier of the browser.
    browser_identifier: []const u8,

    /// The timestamp when the browser session was created.
    created_at: i64,

    /// The unique identifier of the created browser session.
    session_id: []const u8,

    /// The streams associated with this browser session. These include the
    /// automation stream and live view stream.
    streams: ?BrowserSessionStream = null,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .created_at = "createdAt",
        .session_id = "sessionId",
        .streams = "streams",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartBrowserSessionInput, options: Options) !StartBrowserSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockagentcore");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartBrowserSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagentcore", "Bedrock AgentCore", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/browsers/");
    try path_buf.appendSlice(allocator, input.browser_identifier);
    try path_buf.appendSlice(allocator, "/sessions/start");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.extensions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"extensions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.profile_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"profileConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_timeout_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionTimeoutSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.view_port) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"viewPort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.trace_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Trace-Id", v);
    }
    if (input.trace_parent) |v| {
        try request.headers.put(allocator, "traceparent", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartBrowserSessionOutput {
    var result: StartBrowserSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartBrowserSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateIdException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_id_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
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
    if (std.mem.eql(u8, error_code, "RetryableConflictException")) {
        return .{ .arena = arena, .kind = .{ .retryable_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuntimeClientError")) {
        return .{ .arena = arena, .kind = .{ .runtime_client_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
