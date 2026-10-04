const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SessionState = @import("session_state.zig").SessionState;
const Session = @import("session.zig").Session;

pub const ListSessionsInput = struct {
    /// The ID of the cluster to list sessions for.
    cluster_id: []const u8,

    /// The maximum number of sessions to return in each page of results.
    max_results: ?i32 = null,

    /// The pagination token returned by a previous `ListSessions` call. Use it to
    /// retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// An optional filter that limits the results to sessions in the specified
    /// states.
    session_states: ?[]const SessionState = null,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .session_states = "SessionStates",
    };
};

pub const ListSessionsOutput = struct {
    /// The pagination token to use in a subsequent `ListSessions` call to retrieve
    /// the next page of results. This field is absent when there are no more
    /// results.
    next_token: ?[]const u8 = null,

    /// The sessions that match the request.
    sessions: ?[]const Session = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sessions = "Sessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSessionsInput, options: CallOptions) !ListSessionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSessionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.ListSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSessionsOutput, body, allocator);
}
