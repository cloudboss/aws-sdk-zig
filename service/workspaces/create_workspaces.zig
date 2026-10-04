const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspaceRequest = @import("workspace_request.zig").WorkspaceRequest;
const FailedCreateWorkspaceRequest = @import("failed_create_workspace_request.zig").FailedCreateWorkspaceRequest;
const Workspace = @import("workspace.zig").Workspace;

pub const CreateWorkspacesInput = struct {
    /// The WorkSpaces to create. You can specify up to 25 WorkSpaces.
    workspaces: []const WorkspaceRequest,

    pub const json_field_names = .{
        .workspaces = "Workspaces",
    };
};

pub const CreateWorkspacesOutput = struct {
    /// Information about the WorkSpaces that could not be created.
    failed_requests: ?[]const FailedCreateWorkspaceRequest = null,

    /// Information about the WorkSpaces that were created.
    ///
    /// Because this operation is asynchronous, the identifier returned is not
    /// immediately
    /// available for use with other operations. For example, if you call
    /// DescribeWorkspaces before the WorkSpace is created, the information returned
    /// can be incomplete.
    pending_requests: ?[]const Workspace = null,

    pub const json_field_names = .{
        .failed_requests = "FailedRequests",
        .pending_requests = "PendingRequests",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspacesInput, options: CallOptions) !CreateWorkspacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.CreateWorkspaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWorkspacesOutput, body, allocator);
}
