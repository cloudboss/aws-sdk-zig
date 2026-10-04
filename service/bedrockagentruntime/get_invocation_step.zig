const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InvocationStep = @import("invocation_step.zig").InvocationStep;

pub const GetInvocationStepInput = struct {
    /// The unique identifier for the invocation in UUID format.
    invocation_identifier: []const u8,

    /// The unique identifier (in UUID format) for the specific invocation step to
    /// retrieve.
    invocation_step_id: []const u8,

    /// The unique identifier for the invocation step's associated session. You can
    /// specify either the session's `sessionId` or its Amazon Resource Name (ARN).
    session_identifier: []const u8,

    pub const json_field_names = .{
        .invocation_identifier = "invocationIdentifier",
        .invocation_step_id = "invocationStepId",
        .session_identifier = "sessionIdentifier",
    };
};

pub const GetInvocationStepOutput = struct {
    /// The complete details of the requested invocation step.
    invocation_step: ?InvocationStep = null,

    pub const json_field_names = .{
        .invocation_step = "invocationStep",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInvocationStepInput, options: CallOptions) !GetInvocationStepOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInvocationStepInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_identifier);
    try path_buf.appendSlice(allocator, "/invocationSteps/");
    try path_buf.appendSlice(allocator, input.invocation_step_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"invocationIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.invocation_identifier), input.invocation_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInvocationStepOutput {
    var result: GetInvocationStepOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInvocationStepOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
