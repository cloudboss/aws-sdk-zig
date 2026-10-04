const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KafkaCluster = @import("kafka_cluster.zig").KafkaCluster;
const LogDelivery = @import("log_delivery.zig").LogDelivery;
const ReplicationInfo = @import("replication_info.zig").ReplicationInfo;
const ReplicatorState = @import("replicator_state.zig").ReplicatorState;

pub const CreateReplicatorInput = struct {
    /// A summary description of the replicator.
    description: ?[]const u8 = null,

    /// Kafka Clusters to use in setting up sources / targets for replication.
    kafka_clusters: []const KafkaCluster,

    /// Configuration for delivering replicator logs to customer destinations.
    log_delivery: ?LogDelivery = null,

    /// A list of replication configurations, where each configuration targets a
    /// given source cluster to target cluster replication flow.
    replication_info_list: []const ReplicationInfo,

    /// The name of the replicator. Alpha-numeric characters with '-' are allowed.
    replicator_name: []const u8,

    /// The ARN of the IAM role used by the replicator to access resources in the
    /// customer's account (e.g source and target clusters)
    service_execution_role_arn: []const u8,

    /// List of tags to attach to created Replicator.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .kafka_clusters = "KafkaClusters",
        .log_delivery = "LogDelivery",
        .replication_info_list = "ReplicationInfoList",
        .replicator_name = "ReplicatorName",
        .service_execution_role_arn = "ServiceExecutionRoleArn",
        .tags = "Tags",
    };
};

pub const CreateReplicatorOutput = struct {
    /// The Amazon Resource Name (ARN) of the replicator.
    replicator_arn: ?[]const u8 = null,

    /// Name of the replicator provided by the customer.
    replicator_name: ?[]const u8 = null,

    /// State of the replicator.
    replicator_state: ?ReplicatorState = null,

    pub const json_field_names = .{
        .replicator_arn = "ReplicatorArn",
        .replicator_name = "ReplicatorName",
        .replicator_state = "ReplicatorState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReplicatorInput, options: CallOptions) !CreateReplicatorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/replication/v1/replicators";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KafkaClusters\":");
    try aws.json.writeValue(@TypeOf(input.kafka_clusters), input.kafka_clusters, allocator, &body_buf);
    has_prev = true;
    if (input.log_delivery) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogDelivery\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReplicationInfoList\":");
    try aws.json.writeValue(@TypeOf(input.replication_info_list), input.replication_info_list, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReplicatorName\":");
    try aws.json.writeValue(@TypeOf(input.replicator_name), input.replicator_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ServiceExecutionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.service_execution_role_arn), input.service_execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicatorOutput {
    var result: CreateReplicatorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateReplicatorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
