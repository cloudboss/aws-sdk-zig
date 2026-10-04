const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Workspace = @import("workspace.zig").Workspace;

pub const DescribeWorkspacesInput = struct {
    /// The identifier of the bundle. All WorkSpaces that are created from this
    /// bundle are
    /// retrieved. You cannot combine this parameter with any other filter.
    bundle_id: ?[]const u8 = null,

    /// The identifier of the directory. In addition, you can optionally specify a
    /// specific
    /// directory user (see `UserName`). You cannot combine this parameter with any
    /// other filter.
    directory_id: ?[]const u8 = null,

    /// The maximum number of items to return.
    limit: ?i32 = null,

    /// If you received a `NextToken` from a previous call that was paginated,
    /// provide this token to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The name of the directory user. You must specify this parameter with
    /// `DirectoryId`.
    user_name: ?[]const u8 = null,

    /// The identifiers of the WorkSpaces. You cannot combine this parameter with
    /// any other
    /// filter.
    ///
    /// Because the CreateWorkspaces operation is asynchronous, the identifier
    /// it returns is not immediately available. If you immediately call
    /// DescribeWorkspaces with this identifier, no information is returned.
    workspace_ids: ?[]const []const u8 = null,

    /// The name of the user-decoupled WorkSpace.
    workspace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bundle_id = "BundleId",
        .directory_id = "DirectoryId",
        .limit = "Limit",
        .next_token = "NextToken",
        .user_name = "UserName",
        .workspace_ids = "WorkspaceIds",
        .workspace_name = "WorkspaceName",
    };
};

pub const DescribeWorkspacesOutput = struct {
    /// The token to use to retrieve the next page of results. This value is null
    /// when there are
    /// no more results to return.
    next_token: ?[]const u8 = null,

    /// Information about the WorkSpaces.
    ///
    /// Because CreateWorkspaces is an asynchronous operation, some of the
    /// returned information could be incomplete.
    workspaces: ?[]const Workspace = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .workspaces = "Workspaces",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkspacesInput, options: CallOptions) !DescribeWorkspacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkspacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.DescribeWorkspaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkspacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeWorkspacesOutput, body, allocator);
}
