const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SaveBrowserSessionProfileInput = struct {
    /// The unique identifier of the browser associated with the session from which
    /// to save the profile.
    browser_identifier: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock AgentCore ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The unique identifier for the browser profile. This identifier is used to
    /// reference the profile when starting new browser sessions. The identifier
    /// must follow the pattern of an alphanumeric name (up to 48 characters)
    /// followed by a hyphen and a 10-character alphanumeric suffix.
    profile_identifier: []const u8,

    /// The unique identifier of the browser session from which to save the profile.
    /// The session must be active when saving the profile.
    session_id: []const u8,

    /// The trace identifier for request tracking.
    trace_id: ?[]const u8 = null,

    /// The parent trace information for distributed tracing.
    trace_parent: ?[]const u8 = null,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .client_token = "clientToken",
        .profile_identifier = "profileIdentifier",
        .session_id = "sessionId",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
    };
};

pub const SaveBrowserSessionProfileOutput = struct {
    /// The unique identifier of the browser associated with the session from which
    /// the profile was saved.
    browser_identifier: []const u8,

    /// The timestamp when the browser profile was last updated. This value is in
    /// ISO 8601 format.
    last_updated_at: i64,

    /// The unique identifier of the saved browser profile.
    profile_identifier: []const u8,

    /// The unique identifier of the browser session from which the profile was
    /// saved.
    session_id: []const u8,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .last_updated_at = "lastUpdatedAt",
        .profile_identifier = "profileIdentifier",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SaveBrowserSessionProfileInput, options: CallOptions) !SaveBrowserSessionProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: SaveBrowserSessionProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/browser-profiles/");
    try path_buf.appendSlice(allocator, input.profile_identifier);
    try path_buf.appendSlice(allocator, "/save");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"browserIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.browser_identifier), input.browser_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sessionId\":");
    try aws.json.writeValue(@TypeOf(input.session_id), input.session_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SaveBrowserSessionProfileOutput {
    const result: SaveBrowserSessionProfileOutput = try aws.json.parseJsonObject(
        SaveBrowserSessionProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
