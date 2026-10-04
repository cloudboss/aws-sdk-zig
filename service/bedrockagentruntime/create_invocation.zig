const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateInvocationInput = struct {
    /// A description for the interactions in the invocation. For example, "User
    /// asking about weather in Seattle".
    description: ?[]const u8 = null,

    /// A unique identifier for the invocation in UUID format.
    invocation_id: ?[]const u8 = null,

    /// The unique identifier for the associated session for the invocation. You can
    /// specify either the session's `sessionId` or its Amazon Resource Name (ARN).
    session_identifier: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .invocation_id = "invocationId",
        .session_identifier = "sessionIdentifier",
    };
};

pub const CreateInvocationOutput = struct {
    /// The timestamp for when the invocation was created.
    created_at: i64,

    /// The unique identifier for the invocation.
    invocation_id: []const u8,

    /// The unique identifier for the session associated with the invocation.
    session_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .invocation_id = "invocationId",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInvocationInput, options: CallOptions) !CreateInvocationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInvocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_identifier);
    try path_buf.appendSlice(allocator, "/invocations/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.invocation_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"invocationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInvocationOutput {
    const result: CreateInvocationOutput = try aws.json.parseJsonObject(
        CreateInvocationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
