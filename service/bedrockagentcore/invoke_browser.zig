const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrowserAction = @import("browser_action.zig").BrowserAction;
const BrowserActionResult = @import("browser_action_result.zig").BrowserActionResult;

pub const InvokeBrowserInput = struct {
    /// The browser action to perform. Exactly one member of the `BrowserAction`
    /// union must be set per request.
    action: BrowserAction,

    /// The unique identifier of the browser associated with the session. This must
    /// match the identifier used when creating the session with
    /// `StartBrowserSession`.
    browser_identifier: []const u8,

    /// The unique identifier of the browser session on which to perform the action.
    /// This must be an active session created with `StartBrowserSession`.
    session_id: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .browser_identifier = "browserIdentifier",
        .session_id = "sessionId",
    };
};

pub const InvokeBrowserOutput = struct {
    /// The result of the browser action. The member set in the result corresponds
    /// to the action that was performed.
    result: ?BrowserActionResult = null,

    /// The unique identifier of the browser session on which the action was
    /// performed.
    session_id: []const u8,

    pub const json_field_names = .{
        .result = "result",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeBrowserInput, options: CallOptions) !InvokeBrowserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeBrowserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/browsers/");
    try path_buf.appendSlice(allocator, input.browser_identifier);
    try path_buf.appendSlice(allocator, "/sessions/invoke");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amzn-browser-session-id", input.session_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeBrowserOutput {
    var result: InvokeBrowserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(InvokeBrowserOutput, body, allocator);
    }
    _ = status;
    if (headers.get("x-amzn-browser-session-id")) |value| {
        result.session_id = try allocator.dupe(u8, value);
    }

    return result;
}
