const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Certificate = @import("certificate.zig").Certificate;

pub const StartCodeInterpreterSessionInput = struct {
    /// A list of certificates to install in the code interpreter session.
    certificates: ?[]const Certificate = null,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock AgentCore ignores the request, but does not return an error. This
    /// parameter helps prevent the creation of duplicate sessions if there are
    /// temporary network issues.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the code interpreter to use for this session. This
    /// identifier specifies which code interpreter environment to initialize for
    /// the session.
    code_interpreter_identifier: []const u8,

    /// The name of the code interpreter session. This name helps you identify and
    /// manage the session. The name does not need to be unique.
    name: ?[]const u8 = null,

    /// The duration in seconds (time-to-live) after which the session automatically
    /// terminates, regardless of ongoing activity. Defaults to 900 seconds (15
    /// minutes). Recommended minimum: 60 seconds. Maximum allowed: 28,800 seconds
    /// (8 hours).
    session_timeout_seconds: ?i32 = null,

    /// The trace identifier for request tracking.
    trace_id: ?[]const u8 = null,

    /// The parent trace information for distributed tracing.
    trace_parent: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificates = "certificates",
        .client_token = "clientToken",
        .code_interpreter_identifier = "codeInterpreterIdentifier",
        .name = "name",
        .session_timeout_seconds = "sessionTimeoutSeconds",
        .trace_id = "traceId",
        .trace_parent = "traceParent",
    };
};

pub const StartCodeInterpreterSessionOutput = struct {
    /// The identifier of the code interpreter.
    code_interpreter_identifier: []const u8,

    /// The time at which the code interpreter session was created.
    created_at: i64,

    /// The unique identifier of the created code interpreter session.
    session_id: []const u8,

    pub const json_field_names = .{
        .code_interpreter_identifier = "codeInterpreterIdentifier",
        .created_at = "createdAt",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCodeInterpreterSessionInput, options: CallOptions) !StartCodeInterpreterSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCodeInterpreterSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/code-interpreters/");
    try path_buf.appendSlice(allocator, input.code_interpreter_identifier);
    try path_buf.appendSlice(allocator, "/sessions/start");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.certificates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_timeout_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionTimeoutSeconds\":");
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
    if (input.trace_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Trace-Id", v);
    }
    if (input.trace_parent) |v| {
        try request.headers.put(allocator, "traceparent", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCodeInterpreterSessionOutput {
    var result: StartCodeInterpreterSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartCodeInterpreterSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
