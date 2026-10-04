const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Certificate = @import("certificate.zig").Certificate;
const CodeInterpreterSessionStatus = @import("code_interpreter_session_status.zig").CodeInterpreterSessionStatus;

pub const GetCodeInterpreterSessionInput = struct {
    /// The unique identifier of the code interpreter associated with the session.
    code_interpreter_identifier: []const u8,

    /// The unique identifier of the code interpreter session to retrieve.
    session_id: []const u8,

    pub const json_field_names = .{
        .code_interpreter_identifier = "codeInterpreterIdentifier",
        .session_id = "sessionId",
    };
};

pub const GetCodeInterpreterSessionOutput = struct {
    /// The list of certificates installed in the code interpreter session.
    certificates: ?[]const Certificate = null,

    /// The identifier of the code interpreter.
    code_interpreter_identifier: []const u8,

    /// The time at which the code interpreter session was created.
    created_at: i64,

    /// The name of the code interpreter session.
    name: ?[]const u8 = null,

    /// The identifier of the code interpreter session.
    session_id: []const u8,

    /// The timeout period for the code interpreter session in seconds.
    session_timeout_seconds: ?i32 = null,

    /// The current status of the code interpreter session. Possible values include
    /// ACTIVE, STOPPING, and STOPPED.
    status: ?CodeInterpreterSessionStatus = null,

    pub const json_field_names = .{
        .certificates = "certificates",
        .code_interpreter_identifier = "codeInterpreterIdentifier",
        .created_at = "createdAt",
        .name = "name",
        .session_id = "sessionId",
        .session_timeout_seconds = "sessionTimeoutSeconds",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCodeInterpreterSessionInput, options: CallOptions) !GetCodeInterpreterSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCodeInterpreterSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/code-interpreters/");
    try path_buf.appendSlice(allocator, input.code_interpreter_identifier);
    try path_buf.appendSlice(allocator, "/sessions/get");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "sessionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.session_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCodeInterpreterSessionOutput {
    var result: GetCodeInterpreterSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCodeInterpreterSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
