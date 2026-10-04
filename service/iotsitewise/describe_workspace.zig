const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspaceEncryptionConfigurationInfo = @import("workspace_encryption_configuration_info.zig").WorkspaceEncryptionConfigurationInfo;
const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;

pub const DescribeWorkspaceInput = struct {
    /// The name of the workspace.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .workspace_name = "workspaceName",
    };
};

pub const DescribeWorkspaceOutput = struct {
    /// The date the workspace was created, in Unix epoch time.
    created_at: i64,

    /// The encryption configuration information for the workspace.
    encryption_configuration: ?WorkspaceEncryptionConfigurationInfo = null,

    /// The date the workspace was last updated, in Unix epoch time.
    updated_at: i64,

    /// The ARN of the workspace.
    workspace_arn: []const u8,

    /// The description of the workspace.
    workspace_description: ?[]const u8 = null,

    /// The name of the workspace.
    workspace_name: []const u8,

    /// The status of the workspace, which contains the state and any error message.
    workspace_status: ?WorkspaceStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .encryption_configuration = "encryptionConfiguration",
        .updated_at = "updatedAt",
        .workspace_arn = "workspaceArn",
        .workspace_description = "workspaceDescription",
        .workspace_name = "workspaceName",
        .workspace_status = "workspaceStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkspaceInput, options: CallOptions) !DescribeWorkspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkspaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkspaceOutput {
    const result: DescribeWorkspaceOutput = try aws.json.parseJsonObject(
        DescribeWorkspaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
