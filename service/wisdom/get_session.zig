const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SessionData = @import("session_data.zig").SessionData;

pub const GetSessionInput = struct {
    /// The identifier of the Wisdom assistant. Can be either the ID or the ARN.
    /// URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// The identifier of the session. Can be either the ID or the ARN. URLs cannot
    /// contain the ARN.
    session_id: []const u8,

    pub const json_field_names = .{
        .assistant_id = "assistantId",
        .session_id = "sessionId",
    };
};

pub const GetSessionOutput = struct {
    /// The session.
    session: ?SessionData = null,

    pub const json_field_names = .{
        .session = "session",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionInput, options: CallOptions) !GetSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "Wisdom", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionOutput {
    var result: GetSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
