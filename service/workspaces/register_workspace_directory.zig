const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActiveDirectoryConfig = @import("active_directory_config.zig").ActiveDirectoryConfig;
const MicrosoftEntraConfig = @import("microsoft_entra_config.zig").MicrosoftEntraConfig;
const Tag = @import("tag.zig").Tag;
const Tenancy = @import("tenancy.zig").Tenancy;
const UserIdentityType = @import("user_identity_type.zig").UserIdentityType;
const WorkspaceType = @import("workspace_type.zig").WorkspaceType;
const WorkspaceDirectoryState = @import("workspace_directory_state.zig").WorkspaceDirectoryState;

pub const RegisterWorkspaceDirectoryInput = struct {
    /// The active directory config of the directory.
    active_directory_config: ?ActiveDirectoryConfig = null,

    /// The identifier of the directory. You cannot register a directory if it does
    /// not have a
    /// status of Active. If the directory does not have a status of Active, you
    /// will receive an
    /// InvalidResourceStateException error. If you have already registered the
    /// maximum number of
    /// directories that you can register with Amazon WorkSpaces, you will receive a
    /// ResourceLimitExceededException error. Deregister directories that you are
    /// not using for
    /// WorkSpaces, and try again.
    directory_id: ?[]const u8 = null,

    /// Indicates whether self-service capabilities are enabled or disabled.
    enable_self_service: ?bool = null,

    /// The Amazon Resource Name (ARN) of the identity center instance.
    idc_instance_arn: ?[]const u8 = null,

    /// The details about Microsoft Entra config.
    microsoft_entra_config: ?MicrosoftEntraConfig = null,

    /// The identifiers of the subnets for your virtual private cloud (VPC). Make
    /// sure that the
    /// subnets are in supported Availability Zones. The subnets must also be in
    /// separate
    /// Availability Zones. If these conditions are not met, you will receive an
    /// OperationNotSupportedException error.
    subnet_ids: ?[]const []const u8 = null,

    /// The tags associated with the directory.
    tags: ?[]const Tag = null,

    /// Indicates whether your WorkSpace directory is dedicated or shared. To use
    /// Bring Your Own
    /// License (BYOL) images, this value must be set to `DEDICATED` and your Amazon
    /// Web Services account must be enabled for BYOL. If your account has not been
    /// enabled for
    /// BYOL, you will receive an InvalidParameterValuesException error. For more
    /// information about
    /// BYOL images, see [Bring Your Own Windows
    /// Desktop
    /// Images](https://docs.aws.amazon.com/workspaces/latest/adminguide/byol-windows-images.html).
    tenancy: ?Tenancy = null,

    /// The type of identity management the user is using.
    user_identity_type: ?UserIdentityType = null,

    /// Description of the directory to register.
    workspace_directory_description: ?[]const u8 = null,

    /// The name of the directory to register.
    workspace_directory_name: ?[]const u8 = null,

    /// Indicates whether the directory's WorkSpace type is personal or pools.
    workspace_type: ?WorkspaceType = null,

    pub const json_field_names = .{
        .active_directory_config = "ActiveDirectoryConfig",
        .directory_id = "DirectoryId",
        .enable_self_service = "EnableSelfService",
        .idc_instance_arn = "IdcInstanceArn",
        .microsoft_entra_config = "MicrosoftEntraConfig",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .tenancy = "Tenancy",
        .user_identity_type = "UserIdentityType",
        .workspace_directory_description = "WorkspaceDirectoryDescription",
        .workspace_directory_name = "WorkspaceDirectoryName",
        .workspace_type = "WorkspaceType",
    };
};

pub const RegisterWorkspaceDirectoryOutput = struct {
    /// The identifier of the directory.
    directory_id: ?[]const u8 = null,

    /// The registration status of the WorkSpace directory.
    state: ?WorkspaceDirectoryState = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterWorkspaceDirectoryInput, options: CallOptions) !RegisterWorkspaceDirectoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterWorkspaceDirectoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.RegisterWorkspaceDirectory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterWorkspaceDirectoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterWorkspaceDirectoryOutput, body, allocator);
}
