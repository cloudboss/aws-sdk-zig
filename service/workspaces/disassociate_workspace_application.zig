const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspaceResourceAssociation = @import("workspace_resource_association.zig").WorkspaceResourceAssociation;

pub const DisassociateWorkspaceApplicationInput = struct {
    /// The identifier of the application.
    application_id: []const u8,

    /// The identifier of the WorkSpace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .workspace_id = "WorkspaceId",
    };
};

pub const DisassociateWorkspaceApplicationOutput = struct {
    /// Information about the targeted association.
    association: ?WorkspaceResourceAssociation = null,

    pub const json_field_names = .{
        .association = "Association",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateWorkspaceApplicationInput, options: CallOptions) !DisassociateWorkspaceApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateWorkspaceApplicationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.DisassociateWorkspaceApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateWorkspaceApplicationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateWorkspaceApplicationOutput, body, allocator);
}
