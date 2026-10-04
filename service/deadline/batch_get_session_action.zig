const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetSessionActionIdentifier = @import("batch_get_session_action_identifier.zig").BatchGetSessionActionIdentifier;
const BatchGetSessionActionError = @import("batch_get_session_action_error.zig").BatchGetSessionActionError;
const BatchGetSessionActionItem = @import("batch_get_session_action_item.zig").BatchGetSessionActionItem;

pub const BatchGetSessionActionInput = struct {
    /// The list of session action identifiers to retrieve. You can specify up to
    /// 100 identifiers per request.
    identifiers: []const BatchGetSessionActionIdentifier,

    pub const json_field_names = .{
        .identifiers = "identifiers",
    };
};

pub const BatchGetSessionActionOutput = struct {
    /// A list of errors for session actions that could not be retrieved.
    errors: ?[]const BatchGetSessionActionError = null,

    /// A list of session actions that were successfully retrieved.
    session_actions: ?[]const BatchGetSessionActionItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .session_actions = "sessionActions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetSessionActionInput, options: CallOptions) !BatchGetSessionActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetSessionActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2023-10-12/batch-get-session-action";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"identifiers\":");
    try aws.json.writeValue(@TypeOf(input.identifiers), input.identifiers, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetSessionActionOutput {
    var result: BatchGetSessionActionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetSessionActionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
