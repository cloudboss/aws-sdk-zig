const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkSpaceAssociatedResourceType = @import("work_space_associated_resource_type.zig").WorkSpaceAssociatedResourceType;
const WorkspaceResourceAssociation = @import("workspace_resource_association.zig").WorkspaceResourceAssociation;

pub const DescribeWorkspaceAssociationsInput = struct {
    /// The resource types of the associated resources.
    associated_resource_types: []const WorkSpaceAssociatedResourceType,

    /// The identifier of the WorkSpace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .associated_resource_types = "AssociatedResourceTypes",
        .workspace_id = "WorkspaceId",
    };
};

pub const DescribeWorkspaceAssociationsOutput = struct {
    /// List of information about the specified associations.
    associations: ?[]const WorkspaceResourceAssociation = null,

    pub const json_field_names = .{
        .associations = "Associations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkspaceAssociationsInput, options: CallOptions) !DescribeWorkspaceAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkspaceAssociationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.DescribeWorkspaceAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkspaceAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeWorkspaceAssociationsOutput, body, allocator);
}
