const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DaemonDeploymentConfiguration = @import("daemon_deployment_configuration.zig").DaemonDeploymentConfiguration;
const DaemonPropagateTags = @import("daemon_propagate_tags.zig").DaemonPropagateTags;
const Tag = @import("tag.zig").Tag;
const DaemonStatus = @import("daemon_status.zig").DaemonStatus;

pub const CreateDaemonInput = struct {
    /// The Amazon Resource Names (ARNs) of the capacity providers to associate with
    /// the daemon. The daemon deploys tasks on container instances managed by these
    /// capacity providers.
    capacity_provider_arns: []const []const u8,

    /// An identifier that you provide to ensure the idempotency of the request. It
    /// must be unique and is case sensitive. Up to 36 ASCII characters in the range
    /// of 33-126 (inclusive) are allowed.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the cluster to create the daemon in.
    cluster_arn: ?[]const u8 = null,

    /// The name of the daemon. Up to 255 letters (uppercase and lowercase),
    /// numbers, underscores, and hyphens are allowed.
    daemon_name: []const u8,

    /// The Amazon Resource Name (ARN) of the daemon task definition to use for the
    /// daemon.
    daemon_task_definition_arn: []const u8,

    /// Optional deployment parameters that control how the daemon rolls out
    /// updates, including the drain percentage, alarm-based rollback, and bake
    /// time.
    deployment_configuration: ?DaemonDeploymentConfiguration = null,

    /// Specifies whether to turn on Amazon ECS managed tags for the tasks in the
    /// daemon. For more information, see [Tagging your Amazon ECS
    /// resources](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the *Amazon Elastic Container Service Developer Guide*.
    enable_ecs_managed_tags: ?bool = null,

    /// Determines whether the execute command functionality is turned on for the
    /// daemon. If `true`, the execute command functionality is turned on for all
    /// tasks in the daemon.
    enable_execute_command: ?bool = null,

    /// Specifies whether to propagate the tags from the daemon to the daemon tasks.
    /// If you don't specify a value, the tags aren't propagated. You can only
    /// propagate tags to daemon tasks during task creation. To add tags to a task
    /// after task creation, use the
    /// [TagResource](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_TagResource.html) API action.
    propagate_tags: ?DaemonPropagateTags = null,

    /// The metadata that you apply to the daemon to help you categorize and
    /// organize them. Each tag consists of a key and an optional value. You define
    /// both of them.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .capacity_provider_arns = "capacityProviderArns",
        .client_token = "clientToken",
        .cluster_arn = "clusterArn",
        .daemon_name = "daemonName",
        .daemon_task_definition_arn = "daemonTaskDefinitionArn",
        .deployment_configuration = "deploymentConfiguration",
        .enable_ecs_managed_tags = "enableECSManagedTags",
        .enable_execute_command = "enableExecuteCommand",
        .propagate_tags = "propagateTags",
        .tags = "tags",
    };
};

pub const CreateDaemonOutput = struct {
    /// The Unix timestamp for the time when the daemon was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the daemon.
    daemon_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the initial daemon deployment. This
    /// deployment places daemon tasks on each container instance of the specified
    /// capacity providers.
    deployment_arn: ?[]const u8 = null,

    /// The status of the daemon.
    status: ?DaemonStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .daemon_arn = "daemonArn",
        .deployment_arn = "deploymentArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDaemonInput, options: CallOptions) !CreateDaemonOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDaemonInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.CreateDaemon");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDaemonOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDaemonOutput, body, allocator);
}
