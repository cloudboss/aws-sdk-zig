const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StandbyWorkspace = @import("standby_workspace.zig").StandbyWorkspace;
const FailedCreateStandbyWorkspacesRequest = @import("failed_create_standby_workspaces_request.zig").FailedCreateStandbyWorkspacesRequest;
const PendingCreateStandbyWorkspacesRequest = @import("pending_create_standby_workspaces_request.zig").PendingCreateStandbyWorkspacesRequest;

pub const CreateStandbyWorkspacesInput = struct {
    /// The Region of the primary WorkSpace.
    primary_region: []const u8,

    /// Information about the standby WorkSpace to be created.
    standby_workspaces: []const StandbyWorkspace,

    pub const json_field_names = .{
        .primary_region = "PrimaryRegion",
        .standby_workspaces = "StandbyWorkspaces",
    };
};

pub const CreateStandbyWorkspacesOutput = struct {
    /// Information about the standby WorkSpace that could not be created.
    failed_standby_requests: ?[]const FailedCreateStandbyWorkspacesRequest = null,

    /// Information about the standby WorkSpace that was created.
    pending_standby_requests: ?[]const PendingCreateStandbyWorkspacesRequest = null,

    pub const json_field_names = .{
        .failed_standby_requests = "FailedStandbyRequests",
        .pending_standby_requests = "PendingStandbyRequests",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStandbyWorkspacesInput, options: CallOptions) !CreateStandbyWorkspacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStandbyWorkspacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.CreateStandbyWorkspaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStandbyWorkspacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateStandbyWorkspacesOutput, body, allocator);
}
