const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspacesPoolSession = @import("workspaces_pool_session.zig").WorkspacesPoolSession;

pub const DescribeWorkspacesPoolSessionsInput = struct {
    /// The maximum size of each page of results. The default value is 20 and the
    /// maximum value
    /// is 50.
    limit: ?i32 = null,

    /// If you received a `NextToken` from a previous call that was paginated,
    /// provide this token to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The identifier of the pool.
    pool_id: []const u8,

    /// The identifier of the user.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .next_token = "NextToken",
        .pool_id = "PoolId",
        .user_id = "UserId",
    };
};

pub const DescribeWorkspacesPoolSessionsOutput = struct {
    /// If you received a `NextToken` from a previous call that was paginated,
    /// provide this token to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// Describes the pool sessions.
    sessions: ?[]const WorkspacesPoolSession = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .sessions = "Sessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkspacesPoolSessionsInput, options: CallOptions) !DescribeWorkspacesPoolSessionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkspacesPoolSessionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.DescribeWorkspacesPoolSessions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkspacesPoolSessionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeWorkspacesPoolSessionsOutput, body, allocator);
}
