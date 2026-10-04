const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const Cluster = @import("cluster.zig").Cluster;

pub const PutClusterCapacityProvidersInput = struct {
    /// The name of one or more capacity providers to associate with the cluster.
    ///
    /// If specifying a capacity provider that uses an Auto Scaling group, the
    /// capacity provider must already be created. New capacity providers can be
    /// created with the
    /// [CreateCapacityProvider](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateCapacityProvider.html) API operation.
    ///
    /// To use a Fargate capacity provider, specify either the `FARGATE` or
    /// `FARGATE_SPOT` capacity providers. The Fargate capacity providers are
    /// available to all accounts and only need to be associated with a cluster to
    /// be used.
    capacity_providers: []const []const u8,

    /// The short name or full Amazon Resource Name (ARN) of the cluster to modify
    /// the capacity provider settings for. If you don't specify a cluster, the
    /// default cluster is assumed.
    cluster: []const u8,

    /// The capacity provider strategy to use by default for the cluster.
    ///
    /// When creating a service or running a task on a cluster, if no capacity
    /// provider or launch type is specified then the default capacity provider
    /// strategy for the cluster is used.
    ///
    /// A capacity provider strategy consists of one or more capacity providers
    /// along with the `base` and `weight` to assign to them. A capacity provider
    /// must be associated with the cluster to be used in a capacity provider
    /// strategy. The
    /// [PutClusterCapacityProviders](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutClusterCapacityProviders.html) API is used to associate a capacity provider with a cluster. Only capacity providers with an `ACTIVE` or `UPDATING` status can be used.
    ///
    /// If specifying a capacity provider that uses an Auto Scaling group, the
    /// capacity provider must already be created. New capacity providers can be
    /// created with the
    /// [CreateCapacityProvider](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateCapacityProvider.html) API operation.
    ///
    /// To use a Fargate capacity provider, specify either the `FARGATE` or
    /// `FARGATE_SPOT` capacity providers. The Fargate capacity providers are
    /// available to all accounts and only need to be associated with a cluster to
    /// be used.
    default_capacity_provider_strategy: []const CapacityProviderStrategyItem,

    pub const json_field_names = .{
        .capacity_providers = "capacityProviders",
        .cluster = "cluster",
        .default_capacity_provider_strategy = "defaultCapacityProviderStrategy",
    };
};

pub const PutClusterCapacityProvidersOutput = struct {
    /// Details about the cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutClusterCapacityProvidersInput, options: CallOptions) !PutClusterCapacityProvidersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutClusterCapacityProvidersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.PutClusterCapacityProviders");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutClusterCapacityProvidersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutClusterCapacityProvidersOutput, body, allocator);
}
