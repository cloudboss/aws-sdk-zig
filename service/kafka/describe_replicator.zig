const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KafkaClusterDescription = @import("kafka_cluster_description.zig").KafkaClusterDescription;
const LogDelivery = @import("log_delivery.zig").LogDelivery;
const ReplicationInfoDescription = @import("replication_info_description.zig").ReplicationInfoDescription;
const ReplicatorState = @import("replicator_state.zig").ReplicatorState;
const ReplicationStateInfo = @import("replication_state_info.zig").ReplicationStateInfo;

pub const DescribeReplicatorInput = struct {
    /// The Amazon Resource Name (ARN) of the replicator to be described.
    replicator_arn: []const u8,

    pub const json_field_names = .{
        .replicator_arn = "ReplicatorArn",
    };
};

pub const DescribeReplicatorOutput = struct {
    /// The time when the replicator was created.
    creation_time: ?i64 = null,

    /// The current version number of the replicator.
    current_version: ?[]const u8 = null,

    /// Whether this resource is a replicator reference.
    is_replicator_reference: ?bool = null,

    /// Kafka Clusters used in setting up sources / targets for replication.
    kafka_clusters: ?[]const KafkaClusterDescription = null,

    /// Configuration for log delivery.
    log_delivery: ?LogDelivery = null,

    /// A list of replication configurations, where each configuration targets a
    /// given source cluster to target cluster replication flow.
    replication_info_list: ?[]const ReplicationInfoDescription = null,

    /// The Amazon Resource Name (ARN) of the replicator.
    replicator_arn: ?[]const u8 = null,

    /// The description of the replicator.
    replicator_description: ?[]const u8 = null,

    /// The name of the replicator.
    replicator_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the replicator resource in the region
    /// where the replicator was created.
    replicator_resource_arn: ?[]const u8 = null,

    /// State of the replicator.
    replicator_state: ?ReplicatorState = null,

    /// The Amazon Resource Name (ARN) of the IAM role used by the replicator to
    /// access resources in the customer's account (e.g source and target clusters)
    service_execution_role_arn: ?[]const u8 = null,

    /// Details about the state of the replicator.
    state_info: ?ReplicationStateInfo = null,

    /// List of tags attached to the Replicator.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .current_version = "CurrentVersion",
        .is_replicator_reference = "IsReplicatorReference",
        .kafka_clusters = "KafkaClusters",
        .log_delivery = "LogDelivery",
        .replication_info_list = "ReplicationInfoList",
        .replicator_arn = "ReplicatorArn",
        .replicator_description = "ReplicatorDescription",
        .replicator_name = "ReplicatorName",
        .replicator_resource_arn = "ReplicatorResourceArn",
        .replicator_state = "ReplicatorState",
        .service_execution_role_arn = "ServiceExecutionRoleArn",
        .state_info = "StateInfo",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReplicatorInput, options: CallOptions) !DescribeReplicatorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReplicatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/replication/v1/replicators/");
    try path_buf.appendSlice(allocator, input.replicator_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReplicatorOutput {
    const result: DescribeReplicatorOutput = try aws.json.parseJsonObject(
        DescribeReplicatorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
