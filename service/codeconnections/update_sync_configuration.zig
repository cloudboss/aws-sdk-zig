const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PublishDeploymentStatus = @import("publish_deployment_status.zig").PublishDeploymentStatus;
const PullRequestComment = @import("pull_request_comment.zig").PullRequestComment;
const SyncConfigurationType = @import("sync_configuration_type.zig").SyncConfigurationType;
const TriggerResourceUpdateOn = @import("trigger_resource_update_on.zig").TriggerResourceUpdateOn;
const SyncConfiguration = @import("sync_configuration.zig").SyncConfiguration;

pub const UpdateSyncConfigurationInput = struct {
    /// The branch for the sync configuration to be updated.
    branch: ?[]const u8 = null,

    /// The configuration file for the sync configuration to be updated.
    config_file: ?[]const u8 = null,

    /// Whether to enable or disable publishing of deployment status to source
    /// providers.
    publish_deployment_status: ?PublishDeploymentStatus = null,

    /// TA toggle that specifies whether to enable or disable pull request comments
    /// for the sync configuration to be updated.
    pull_request_comment: ?PullRequestComment = null,

    /// The ID of the repository link for the sync configuration to be updated.
    repository_link_id: ?[]const u8 = null,

    /// The name of the Amazon Web Services resource for the sync configuration to
    /// be
    /// updated.
    resource_name: []const u8,

    /// The ARN of the IAM role for the sync configuration to be updated.
    role_arn: ?[]const u8 = null,

    /// The sync type for the sync configuration to be updated.
    sync_type: SyncConfigurationType,

    /// When to trigger Git sync to begin the stack update.
    trigger_resource_update_on: ?TriggerResourceUpdateOn = null,

    pub const json_field_names = .{
        .branch = "Branch",
        .config_file = "ConfigFile",
        .publish_deployment_status = "PublishDeploymentStatus",
        .pull_request_comment = "PullRequestComment",
        .repository_link_id = "RepositoryLinkId",
        .resource_name = "ResourceName",
        .role_arn = "RoleArn",
        .sync_type = "SyncType",
        .trigger_resource_update_on = "TriggerResourceUpdateOn",
    };
};

pub const UpdateSyncConfigurationOutput = struct {
    /// The information returned for the sync configuration to be updated.
    sync_configuration: ?SyncConfiguration = null,

    pub const json_field_names = .{
        .sync_configuration = "SyncConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSyncConfigurationInput, options: CallOptions) !UpdateSyncConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeconnections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSyncConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeconnections", "CodeConnections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.UpdateSyncConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSyncConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateSyncConfigurationOutput, body, allocator);
}
