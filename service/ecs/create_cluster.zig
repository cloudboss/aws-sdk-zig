const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterConfiguration = @import("cluster_configuration.zig").ClusterConfiguration;
const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const ClusterServiceConnectDefaultsRequest = @import("cluster_service_connect_defaults_request.zig").ClusterServiceConnectDefaultsRequest;
const ClusterSetting = @import("cluster_setting.zig").ClusterSetting;
const Tag = @import("tag.zig").Tag;
const Cluster = @import("cluster.zig").Cluster;

pub const CreateClusterInput = struct {
    /// The short name of one or more capacity providers to associate with the
    /// cluster. A capacity provider must be associated with a cluster before it can
    /// be included as part of the default capacity provider strategy of the cluster
    /// or used in a capacity provider strategy when calling the
    /// [CreateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateService.html) or [RunTask](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RunTask.html) actions.
    ///
    /// If specifying a capacity provider that uses an Auto Scaling group, the
    /// capacity provider must be created but not associated with another cluster.
    /// New Auto Scaling group capacity providers can be created with the
    /// [CreateCapacityProvider](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateCapacityProvider.html) API operation.
    ///
    /// To use a Fargate capacity provider, specify either the `FARGATE` or
    /// `FARGATE_SPOT` capacity providers. The Fargate capacity providers are
    /// available to all accounts and only need to be associated with a cluster to
    /// be used.
    ///
    /// The
    /// [PutCapacityProvider](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutCapacityProvider.html) API operation is used to update the list of available capacity providers for a cluster after the cluster is created.
    capacity_providers: ?[]const []const u8 = null,

    /// The name of your cluster. If you don't specify a name for your cluster, you
    /// create a cluster that's named `default`. Up to 255 letters (uppercase and
    /// lowercase), numbers, underscores, and hyphens are allowed.
    cluster_name: ?[]const u8 = null,

    /// The `execute` command configuration for the cluster.
    configuration: ?ClusterConfiguration = null,

    /// The capacity provider strategy to set as the default for the cluster. After
    /// a default capacity provider strategy is set for a cluster, when you call the
    /// [CreateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateService.html) or [RunTask](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RunTask.html) APIs with no capacity provider strategy or launch type specified, the default capacity provider strategy for the cluster is used.
    ///
    /// If a default capacity provider strategy isn't defined for a cluster when it
    /// was created, it can be defined later with the
    /// [PutClusterCapacityProviders](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutClusterCapacityProviders.html) API operation.
    default_capacity_provider_strategy: ?[]const CapacityProviderStrategyItem = null,

    /// Use this parameter to set a default Service Connect namespace. After you set
    /// a default Service Connect namespace, any new services with Service Connect
    /// turned on that are created in the cluster are added as client services in
    /// the namespace. This setting only applies to new services that set the
    /// `enabled` parameter to `true` in the `ServiceConnectConfiguration`. You can
    /// set the namespace of each service individually in the
    /// `ServiceConnectConfiguration` to override this default parameter.
    ///
    /// Tasks that run in a namespace can use short names to connect to services in
    /// the namespace. Tasks can connect to services across all of the clusters in
    /// the namespace. Tasks connect through a managed proxy container that collects
    /// logs and metrics for increased visibility. Only the tasks that Amazon ECS
    /// services create are supported with Service Connect. For more information,
    /// see [Service
    /// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.
    service_connect_defaults: ?ClusterServiceConnectDefaultsRequest = null,

    /// The setting to use when creating a cluster. This parameter is used to turn
    /// on CloudWatch Container Insights for a cluster. If this value is specified,
    /// it overrides the `containerInsights` value set with
    /// [PutAccountSetting](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutAccountSetting.html) or [PutAccountSettingDefault](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutAccountSettingDefault.html).
    settings: ?[]const ClusterSetting = null,

    /// The metadata that you apply to the cluster to help you categorize and
    /// organize them. Each tag consists of a key and an optional value. You define
    /// both.
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
        .capacity_providers = "capacityProviders",
        .cluster_name = "clusterName",
        .configuration = "configuration",
        .default_capacity_provider_strategy = "defaultCapacityProviderStrategy",
        .service_connect_defaults = "serviceConnectDefaults",
        .settings = "settings",
        .tags = "tags",
    };
};

pub const CreateClusterOutput = struct {
    /// The full description of your new cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: CallOptions) !CreateClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.CreateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateClusterOutput, body, allocator);
}
