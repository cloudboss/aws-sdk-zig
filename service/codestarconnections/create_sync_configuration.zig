const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PublishDeploymentStatus = @import("publish_deployment_status.zig").PublishDeploymentStatus;
const SyncConfigurationType = @import("sync_configuration_type.zig").SyncConfigurationType;
const TriggerResourceUpdateOn = @import("trigger_resource_update_on.zig").TriggerResourceUpdateOn;
const SyncConfiguration = @import("sync_configuration.zig").SyncConfiguration;

pub const CreateSyncConfigurationInput = struct {
    /// The branch in the repository from which changes will be synced.
    branch: []const u8,

    /// The file name of the configuration file that manages syncing between the
    /// connection and the repository. This configuration file is stored in the
    /// repository.
    config_file: []const u8,

    /// Whether to enable or disable publishing of deployment status to source
    /// providers.
    publish_deployment_status: ?PublishDeploymentStatus = null,

    /// The ID of the repository link created for the connection. A repository link
    /// allows Git
    /// sync to monitor and sync changes to files in a specified Git repository.
    repository_link_id: []const u8,

    /// The name of the Amazon Web Services resource (for example, a CloudFormation
    /// stack in the
    /// case of CFN_STACK_SYNC) that will be synchronized from the linked
    /// repository.
    resource_name: []const u8,

    /// The ARN of the IAM role that grants permission for Amazon Web Services to
    /// use Git sync to
    /// update a given Amazon Web Services resource on your behalf.
    role_arn: []const u8,

    /// The type of sync configuration.
    sync_type: SyncConfigurationType,

    /// When to trigger Git sync to begin the stack update.
    trigger_resource_update_on: ?TriggerResourceUpdateOn = null,

    pub const json_field_names = .{
        .branch = "Branch",
        .config_file = "ConfigFile",
        .publish_deployment_status = "PublishDeploymentStatus",
        .repository_link_id = "RepositoryLinkId",
        .resource_name = "ResourceName",
        .role_arn = "RoleArn",
        .sync_type = "SyncType",
        .trigger_resource_update_on = "TriggerResourceUpdateOn",
    };
};

pub const CreateSyncConfigurationOutput = struct {
    /// The created sync configuration for the connection. A sync configuration
    /// allows Amazon Web Services to sync content from a Git repository to update a
    /// specified Amazon Web Services
    /// resource.
    sync_configuration: ?SyncConfiguration = null,

    pub const json_field_names = .{
        .sync_configuration = "SyncConfiguration",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSyncConfigurationInput, options: Options) !CreateSyncConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codestarconnections");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSyncConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestarconnections", "CodeStar connections", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "CodeStar_connections_20191201.CreateSyncConfiguration");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateSyncConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSyncConfigurationOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConditionalCheckFailedException")) {
        return .{ .arena = arena, .kind = .{ .conditional_check_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "RetryLatestCommitFailedException")) {
        return .{ .arena = arena, .kind = .{ .retry_latest_commit_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SyncBlockerDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .sync_blocker_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SyncConfigurationStillExistsException")) {
        return .{ .arena = arena, .kind = .{ .sync_configuration_still_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedProviderTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_provider_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpdateOutOfSyncException")) {
        return .{ .arena = arena, .kind = .{ .update_out_of_sync_exception = .{
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
