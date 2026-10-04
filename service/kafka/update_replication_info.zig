const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConsumerGroupReplicationUpdate = @import("consumer_group_replication_update.zig").ConsumerGroupReplicationUpdate;
const LogDelivery = @import("log_delivery.zig").LogDelivery;
const TopicReplicationUpdate = @import("topic_replication_update.zig").TopicReplicationUpdate;
const ReplicatorState = @import("replicator_state.zig").ReplicatorState;

pub const UpdateReplicationInfoInput = struct {
    /// Updated consumer group replication information.
    consumer_group_replication: ?ConsumerGroupReplicationUpdate = null,

    /// Current replicator version.
    current_version: []const u8,

    /// Configuration for delivering replicator logs to customer destinations.
    log_delivery: ?LogDelivery = null,

    /// The Amazon Resource Name (ARN) of the replicator to be updated.
    replicator_arn: []const u8,

    /// The ARN of the source Kafka cluster.
    source_kafka_cluster_arn: ?[]const u8 = null,

    /// The ID of the source Kafka cluster.
    source_kafka_cluster_id: ?[]const u8 = null,

    /// The ARN of the target Kafka cluster.
    target_kafka_cluster_arn: ?[]const u8 = null,

    /// The ID of the target Kafka cluster.
    target_kafka_cluster_id: ?[]const u8 = null,

    /// Updated topic replication information.
    topic_replication: ?TopicReplicationUpdate = null,

    pub const json_field_names = .{
        .consumer_group_replication = "ConsumerGroupReplication",
        .current_version = "CurrentVersion",
        .log_delivery = "LogDelivery",
        .replicator_arn = "ReplicatorArn",
        .source_kafka_cluster_arn = "SourceKafkaClusterArn",
        .source_kafka_cluster_id = "SourceKafkaClusterId",
        .target_kafka_cluster_arn = "TargetKafkaClusterArn",
        .target_kafka_cluster_id = "TargetKafkaClusterId",
        .topic_replication = "TopicReplication",
    };
};

pub const UpdateReplicationInfoOutput = struct {
    /// The Amazon Resource Name (ARN) of the replicator.
    replicator_arn: ?[]const u8 = null,

    /// State of the replicator.
    replicator_state: ?ReplicatorState = null,

    pub const json_field_names = .{
        .replicator_arn = "ReplicatorArn",
        .replicator_state = "ReplicatorState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateReplicationInfoInput, options: CallOptions) !UpdateReplicationInfoOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateReplicationInfoInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/replication/v1/replicators/");
    try path_buf.appendSlice(allocator, input.replicator_arn);
    try path_buf.appendSlice(allocator, "/replication-info");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.consumer_group_replication) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConsumerGroupReplication\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CurrentVersion\":");
    try aws.json.writeValue(@TypeOf(input.current_version), input.current_version, allocator, &body_buf);
    has_prev = true;
    if (input.log_delivery) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogDelivery\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_kafka_cluster_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceKafkaClusterArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_kafka_cluster_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceKafkaClusterId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_kafka_cluster_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetKafkaClusterArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_kafka_cluster_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetKafkaClusterId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.topic_replication) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TopicReplication\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateReplicationInfoOutput {
    var result: UpdateReplicationInfoOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateReplicationInfoOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
