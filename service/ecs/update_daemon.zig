const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DaemonDeploymentConfiguration = @import("daemon_deployment_configuration.zig").DaemonDeploymentConfiguration;
const DaemonPropagateTags = @import("daemon_propagate_tags.zig").DaemonPropagateTags;
const DaemonStatus = @import("daemon_status.zig").DaemonStatus;

pub const UpdateDaemonInput = struct {
    /// The Amazon Resource Names (ARNs) of the capacity providers to associate with
    /// the daemon.
    capacity_provider_arns: []const []const u8,

    /// The Amazon Resource Name (ARN) of the daemon to update.
    daemon_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the daemon task definition to use for the
    /// updated daemon.
    daemon_task_definition_arn: []const u8,

    /// Optional deployment parameters that control how the daemon rolls out
    /// updates, including the drain percentage, alarm-based rollback, and bake
    /// time.
    deployment_configuration: ?DaemonDeploymentConfiguration = null,

    /// Specifies whether to turn on Amazon ECS managed tags for the tasks in the
    /// daemon. For more information, see [Tagging your Amazon ECS
    /// resources](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the *Amazon Elastic Container Service Developer Guide*.
    enable_ecs_managed_tags: ?bool = null,

    /// If `true`, the execute command functionality is turned on for all tasks in
    /// the daemon. If `false`, the execute command functionality is turned off.
    enable_execute_command: ?bool = null,

    /// Specifies whether to propagate the tags from the daemon to the daemon tasks.
    /// If you don't specify a value, the tags aren't propagated. You can only
    /// propagate tags to daemon tasks during task creation.
    propagate_tags: ?DaemonPropagateTags = null,

    pub const json_field_names = .{
        .capacity_provider_arns = "capacityProviderArns",
        .daemon_arn = "daemonArn",
        .daemon_task_definition_arn = "daemonTaskDefinitionArn",
        .deployment_configuration = "deploymentConfiguration",
        .enable_ecs_managed_tags = "enableECSManagedTags",
        .enable_execute_command = "enableExecuteCommand",
        .propagate_tags = "propagateTags",
    };
};

pub const UpdateDaemonOutput = struct {
    /// The Unix timestamp for the time when the daemon was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the daemon.
    daemon_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the daemon deployment that was triggered
    /// by the update.
    deployment_arn: ?[]const u8 = null,

    /// The status of the daemon.
    status: ?DaemonStatus = null,

    /// The Unix timestamp for the time when the daemon was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .daemon_arn = "daemonArn",
        .deployment_arn = "deploymentArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDaemonInput, options: CallOptions) !UpdateDaemonOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDaemonInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.UpdateDaemon");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDaemonOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDaemonOutput, body, allocator);
}
