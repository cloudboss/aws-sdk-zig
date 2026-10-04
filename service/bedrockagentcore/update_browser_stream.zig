const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamUpdate = @import("stream_update.zig").StreamUpdate;
const BrowserSessionStream = @import("browser_session_stream.zig").BrowserSessionStream;

pub const UpdateBrowserStreamInput = struct {
    /// The identifier of the browser.
    browser_identifier: []const u8,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The identifier of the browser session.
    session_id: []const u8,

    /// The update to apply to the browser stream.
    stream_update: StreamUpdate,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .client_token = "clientToken",
        .session_id = "sessionId",
        .stream_update = "streamUpdate",
    };
};

pub const UpdateBrowserStreamOutput = struct {
    /// The identifier of the browser.
    browser_identifier: []const u8,

    /// The identifier of the browser session.
    session_id: []const u8,

    streams: ?BrowserSessionStream = null,

    /// The time at which the browser stream was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .session_id = "sessionId",
        .streams = "streams",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBrowserStreamInput, options: CallOptions) !UpdateBrowserStreamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBrowserStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/browsers/");
    try path_buf.appendSlice(allocator, input.browser_identifier);
    try path_buf.appendSlice(allocator, "/sessions/streams/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "sessionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.session_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"streamUpdate\":");
    try aws.json.writeValue(@TypeOf(input.stream_update), input.stream_update, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBrowserStreamOutput {
    var result: UpdateBrowserStreamOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBrowserStreamOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
