const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpDiscovery = @import("ip_discovery.zig").IpDiscovery;
const ReplicaConfigurationRequest = @import("replica_configuration_request.zig").ReplicaConfigurationRequest;
const ShardConfigurationRequest = @import("shard_configuration_request.zig").ShardConfigurationRequest;
const Cluster = @import("cluster.zig").Cluster;

pub const UpdateClusterInput = struct {
    /// The Access Control List that is associated with the cluster.
    acl_name: ?[]const u8 = null,

    /// The name of the cluster to update.
    cluster_name: []const u8,

    /// The description of the cluster to update.
    description: ?[]const u8 = null,

    /// The name of the engine to be used for the cluster.
    engine: ?[]const u8 = null,

    /// The upgraded version of the engine to be run on the nodes. You can upgrade
    /// to a newer engine version, but you cannot downgrade to an earlier engine
    /// version. If you want to use an earlier engine version, you must delete the
    /// existing cluster and create it anew with the earlier engine version.
    engine_version: ?[]const u8 = null,

    /// The mechanism for discovering IP addresses for the cluster discovery
    /// protocol. Valid values are 'ipv4' or 'ipv6'. When set to 'ipv4', cluster
    /// discovery functions such as cluster slots, cluster shards, and cluster nodes
    /// will return IPv4 addresses for cluster nodes. When set to 'ipv6', the
    /// cluster discovery functions return IPv6 addresses for cluster nodes. The
    /// value must be compatible with the NetworkType parameter. If not specified,
    /// the default is 'ipv4'.
    ip_discovery: ?IpDiscovery = null,

    /// Specifies the weekly time range during which maintenance
    /// on the cluster is performed. It is specified as a range in
    /// the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum
    /// maintenance window is a 60 minute period.
    ///
    /// Valid values for `ddd` are:
    ///
    /// * `sun`
    ///
    /// * `mon`
    ///
    /// * `tue`
    ///
    /// * `wed`
    ///
    /// * `thu`
    ///
    /// * `fri`
    ///
    /// * `sat`
    ///
    /// Example: `sun:23:00-mon:01:30`
    maintenance_window: ?[]const u8 = null,

    /// A valid node type that you want to scale this cluster up or down to.
    node_type: ?[]const u8 = null,

    /// The name of the parameter group to update.
    parameter_group_name: ?[]const u8 = null,

    /// The number of replicas that will reside in each shard.
    replica_configuration: ?ReplicaConfigurationRequest = null,

    /// The SecurityGroupIds to update.
    security_group_ids: ?[]const []const u8 = null,

    /// The number of shards in the cluster.
    shard_configuration: ?ShardConfigurationRequest = null,

    /// The number of days for which MemoryDB retains automatic cluster snapshots
    /// before deleting them. For example, if you set SnapshotRetentionLimit to 5, a
    /// snapshot that was taken today is retained for 5 days before being deleted.
    snapshot_retention_limit: ?i32 = null,

    /// The daily time range (in UTC) during which MemoryDB begins taking a daily
    /// snapshot of your cluster.
    snapshot_window: ?[]const u8 = null,

    /// The SNS topic ARN to update.
    sns_topic_arn: ?[]const u8 = null,

    /// The status of the Amazon SNS notification topic. Notifications are sent only
    /// if the status is active.
    sns_topic_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .acl_name = "ACLName",
        .cluster_name = "ClusterName",
        .description = "Description",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .ip_discovery = "IpDiscovery",
        .maintenance_window = "MaintenanceWindow",
        .node_type = "NodeType",
        .parameter_group_name = "ParameterGroupName",
        .replica_configuration = "ReplicaConfiguration",
        .security_group_ids = "SecurityGroupIds",
        .shard_configuration = "ShardConfiguration",
        .snapshot_retention_limit = "SnapshotRetentionLimit",
        .snapshot_window = "SnapshotWindow",
        .sns_topic_arn = "SnsTopicArn",
        .sns_topic_status = "SnsTopicStatus",
    };
};

pub const UpdateClusterOutput = struct {
    /// The updated cluster.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterInput, options: CallOptions) !UpdateClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.UpdateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateClusterOutput, body, allocator);
}
