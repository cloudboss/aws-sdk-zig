const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSyncConfigurationInput, options: CallOptions) !CreateSyncConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codestar-connections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSyncConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-connections", "CodeStar connections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeStar_connections_20191201.CreateSyncConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSyncConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateSyncConfigurationOutput, body, allocator);
}
