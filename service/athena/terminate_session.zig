const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SessionState = @import("session_state.zig").SessionState;

pub const TerminateSessionInput = struct {
    /// The session ID.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_id = "SessionId",
    };
};

pub const TerminateSessionOutput = struct {
    /// The state of the session. A description of each state follows.
    ///
    /// `CREATING` - The session is being started, including acquiring
    /// resources.
    ///
    /// `CREATED` - The session has been started.
    ///
    /// `IDLE` - The session is able to accept a calculation.
    ///
    /// `BUSY` - The session is processing another task and is unable to accept a
    /// calculation.
    ///
    /// `TERMINATING` - The session is in the process of shutting down.
    ///
    /// `TERMINATED` - The session and its resources are no longer running.
    ///
    /// `DEGRADED` - The session has no healthy coordinators.
    ///
    /// `FAILED` - Due to a failure, the session and its resources are no longer
    /// running.
    state: ?SessionState = null,

    pub const json_field_names = .{
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TerminateSessionInput, options: CallOptions) !TerminateSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TerminateSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.TerminateSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TerminateSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TerminateSessionOutput, body, allocator);
}
