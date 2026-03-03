const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "workspaces");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterWorkspaceDirectoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ApplicationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .application_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ComputeNotCompatibleException")) {
        return .{ .arena = arena, .kind = .{ .compute_not_compatible_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleApplicationsException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_applications_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValuesException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_values_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperatingSystemNotCompatibleException")) {
        return .{ .arena = arena, .kind = .{ .operating_system_not_compatible_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .operation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAssociatedException")) {
        return .{ .arena = arena, .kind = .{ .resource_associated_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceCreationFailedException")) {
        return .{ .arena = arena, .kind = .{ .resource_creation_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedNetworkConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_network_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedWorkspaceConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_workspace_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WorkspacesDefaultRoleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .workspaces_default_role_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
