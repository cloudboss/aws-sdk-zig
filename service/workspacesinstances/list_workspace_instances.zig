const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisionStateEnum = @import("provision_state_enum.zig").ProvisionStateEnum;
const WorkspaceInstance = @import("workspace_instance.zig").WorkspaceInstance;

pub const ListWorkspaceInstancesInput = struct {
    /// Maximum number of WorkSpaces Instances to return in a single response.
    max_results: ?i32 = null,

    /// Pagination token for retrieving subsequent pages of WorkSpaces Instances.
    next_token: ?[]const u8 = null,

    /// Filter WorkSpaces Instances by their current provisioning states.
    provision_states: ?[]const ProvisionStateEnum = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .provision_states = "ProvisionStates",
    };
};

pub const ListWorkspaceInstancesOutput = struct {
    /// Token for retrieving additional WorkSpaces Instances if the result set is
    /// paginated.
    next_token: ?[]const u8 = null,

    /// Collection of WorkSpaces Instances returned by the query.
    workspace_instances: ?[]const WorkspaceInstance = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .workspace_instances = "WorkspaceInstances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkspaceInstancesInput, options: CallOptions) !ListWorkspaceInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-instances", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkspaceInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-instances", "Workspaces Instances", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "EUCMIFrontendAPIService.ListWorkspaceInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkspaceInstancesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListWorkspaceInstancesOutput, body, allocator);
}
