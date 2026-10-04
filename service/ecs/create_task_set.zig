const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const LaunchType = @import("launch_type.zig").LaunchType;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const Scale = @import("scale.zig").Scale;
const ServiceRegistry = @import("service_registry.zig").ServiceRegistry;
const Tag = @import("tag.zig").Tag;
const TaskSet = @import("task_set.zig").TaskSet;

pub const CreateTaskSetInput = struct {
    /// The capacity provider strategy to use for the task set.
    ///
    /// A capacity provider strategy consists of one or more capacity providers
    /// along with the `base` and `weight` to assign to them. A capacity provider
    /// must be associated with the cluster to be used in a capacity provider
    /// strategy. The
    /// [PutClusterCapacityProviders](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutClusterCapacityProviders.html) API is used to associate a capacity provider with a cluster. Only capacity providers with an `ACTIVE` or `UPDATING` status can be used.
    ///
    /// If a `capacityProviderStrategy` is specified, the `launchType` parameter
    /// must be omitted. If no `capacityProviderStrategy` or `launchType` is
    /// specified, the `defaultCapacityProviderStrategy` for the cluster is used.
    ///
    /// If specifying a capacity provider that uses an Auto Scaling group, the
    /// capacity provider must already be created. New capacity providers can be
    /// created with the
    /// [CreateCapacityProviderProvider](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateCapacityProviderProvider.html)API operation.
    ///
    /// To use a Fargate capacity provider, specify either the `FARGATE` or
    /// `FARGATE_SPOT` capacity providers. The Fargate capacity providers are
    /// available to all accounts and only need to be associated with a cluster to
    /// be used.
    ///
    /// The
    /// [PutClusterCapacityProviders](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutClusterCapacityProviders.html) API operation is used to update the list of available capacity providers for a cluster after the cluster is created.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem = null,

    /// An identifier that you provide to ensure the idempotency of the request. It
    /// must be unique and is case sensitive. Up to 36 ASCII characters in the range
    /// of 33-126 (inclusive) are allowed.
    client_token: ?[]const u8 = null,

    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the service to create the task set in.
    cluster: []const u8,

    /// An optional non-unique tag that identifies this task set in external
    /// systems. If the task set is associated with a service discovery registry,
    /// the tasks in this task set will have the `ECS_TASK_SET_EXTERNAL_ID` Cloud
    /// Map attribute set to the provided value.
    external_id: ?[]const u8 = null,

    /// The launch type that new tasks in the task set uses. For more information,
    /// see [Amazon ECS launch
    /// types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// If a `launchType` is specified, the `capacityProviderStrategy` parameter
    /// must be omitted.
    launch_type: ?LaunchType = null,

    /// A load balancer object representing the load balancer to use with the task
    /// set. The supported load balancer types are either an Application Load
    /// Balancer or a Network Load Balancer.
    load_balancers: ?[]const LoadBalancer = null,

    /// An object representing the network configuration for a task set.
    network_configuration: ?NetworkConfiguration = null,

    /// The platform version that the tasks in the task set uses. A platform version
    /// is specified only for tasks using the Fargate launch type. If one isn't
    /// specified, the `LATEST` platform version is used.
    platform_version: ?[]const u8 = null,

    /// A floating-point percentage of the desired number of tasks to place and keep
    /// running in the task set.
    scale: ?Scale = null,

    /// The short name or full Amazon Resource Name (ARN) of the service to create
    /// the task set in.
    service: []const u8,

    /// The details of the service discovery registries to assign to this task set.
    /// For more information, see [Service
    /// discovery](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html).
    service_registries: ?[]const ServiceRegistry = null,

    /// The metadata that you apply to the task set to help you categorize and
    /// organize them. Each tag consists of a key and an optional value. You define
    /// both. When a service is deleted, the tags are deleted.
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

    /// The task definition for the tasks in the task set to use. If a revision
    /// isn't specified, the latest `ACTIVE` revision is used.
    task_definition: []const u8,

    pub const json_field_names = .{
        .capacity_provider_strategy = "capacityProviderStrategy",
        .client_token = "clientToken",
        .cluster = "cluster",
        .external_id = "externalId",
        .launch_type = "launchType",
        .load_balancers = "loadBalancers",
        .network_configuration = "networkConfiguration",
        .platform_version = "platformVersion",
        .scale = "scale",
        .service = "service",
        .service_registries = "serviceRegistries",
        .tags = "tags",
        .task_definition = "taskDefinition",
    };
};

pub const CreateTaskSetOutput = struct {
    /// Information about a set of Amazon ECS tasks in either an CodeDeploy or an
    /// `EXTERNAL` deployment. A task set includes details such as the desired
    /// number of tasks, how many tasks are running, and whether the task set serves
    /// production traffic.
    task_set: ?TaskSet = null,

    pub const json_field_names = .{
        .task_set = "taskSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTaskSetInput, options: CallOptions) !CreateTaskSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTaskSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.CreateTaskSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTaskSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTaskSetOutput, body, allocator);
}
