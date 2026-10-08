const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterConfiguration = @import("cluster_configuration.zig").ClusterConfiguration;
const ClusterServiceConnectDefaultsRequest = @import("cluster_service_connect_defaults_request.zig").ClusterServiceConnectDefaultsRequest;
const ClusterSetting = @import("cluster_setting.zig").ClusterSetting;
const Cluster = @import("cluster.zig").Cluster;

pub const UpdateClusterInput = struct {
    /// The name of the cluster to modify the settings for.
    cluster: []const u8,

    /// The execute command configuration for the cluster.
    configuration: ?ClusterConfiguration = null,

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

    /// The cluster settings for your cluster.
    settings: ?[]const ClusterSetting = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .configuration = "configuration",
        .service_connect_defaults = "serviceConnectDefaults",
        .settings = "settings",
    };
};

pub const UpdateClusterOutput = struct {
    /// Details about the cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterInput, options: CallOptions) !UpdateClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.UpdateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateClusterOutput, body, allocator);
}
