const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribeWorkspacesPoolsFilter = @import("describe_workspaces_pools_filter.zig").DescribeWorkspacesPoolsFilter;
const WorkspacesPool = @import("workspaces_pool.zig").WorkspacesPool;

pub const DescribeWorkspacesPoolsInput = struct {
    /// The filter conditions for the WorkSpaces Pool to return.
    filters: ?[]const DescribeWorkspacesPoolsFilter = null,

    /// The maximum number of items to return.
    limit: ?i32 = null,

    /// If you received a `NextToken` from a previous call that was paginated,
    /// provide this token to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The identifier of the WorkSpaces Pools.
    pool_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .limit = "Limit",
        .next_token = "NextToken",
        .pool_ids = "PoolIds",
    };
};

pub const DescribeWorkspacesPoolsOutput = struct {
    /// If you received a `NextToken` from a previous call that was paginated,
    /// provide this token to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// Information about the WorkSpaces Pools.
    workspaces_pools: ?[]const WorkspacesPool = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .workspaces_pools = "WorkspacesPools",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkspacesPoolsInput, options: CallOptions) !DescribeWorkspacesPoolsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkspacesPoolsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.DescribeWorkspacesPools");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkspacesPoolsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeWorkspacesPoolsOutput, body, allocator);
}
