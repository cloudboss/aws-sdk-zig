const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteEventInput = struct {
    /// The identifier of the actor associated with the event to delete.
    actor_id: []const u8,

    /// The identifier of the event to delete.
    event_id: []const u8,

    /// The identifier of the AgentCore Memory resource from which to delete the
    /// event.
    memory_id: []const u8,

    /// The identifier of the session containing the event to delete.
    session_id: []const u8,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .event_id = "eventId",
        .memory_id = "memoryId",
        .session_id = "sessionId",
    };
};

pub const DeleteEventOutput = struct {
    /// The identifier of the event that was deleted.
    event_id: []const u8,

    pub const json_field_names = .{
        .event_id = "eventId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteEventInput, options: CallOptions) !DeleteEventOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memories/");
    try path_buf.appendSlice(allocator, input.memory_id);
    try path_buf.appendSlice(allocator, "/actor/");
    try path_buf.appendSlice(allocator, input.actor_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    try path_buf.appendSlice(allocator, "/events/");
    try path_buf.appendSlice(allocator, input.event_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteEventOutput {
    const result: DeleteEventOutput = try aws.json.parseJsonObject(
        DeleteEventOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
