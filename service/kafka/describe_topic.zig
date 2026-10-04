const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TopicState = @import("topic_state.zig").TopicState;

pub const DescribeTopicInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: []const u8,

    /// The Kafka topic name that uniquely identifies the topic.
    topic_name: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .topic_name = "TopicName",
    };
};

pub const DescribeTopicOutput = struct {
    /// Topic configurations encoded as a Base64 string.
    configs: ?[]const u8 = null,

    /// The partition count of the topic.
    partition_count: ?i32 = null,

    /// The replication factor of the topic.
    replication_factor: ?i32 = null,

    /// The status of the topic.
    status: ?TopicState = null,

    /// The Amazon Resource Name (ARN) of the topic.
    topic_arn: ?[]const u8 = null,

    /// The Kafka topic name of the topic.
    topic_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .configs = "Configs",
        .partition_count = "PartitionCount",
        .replication_factor = "ReplicationFactor",
        .status = "Status",
        .topic_arn = "TopicArn",
        .topic_name = "TopicName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTopicInput, options: CallOptions) !DescribeTopicOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTopicInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_arn);
    try path_buf.appendSlice(allocator, "/topics/");
    try path_buf.appendSlice(allocator, input.topic_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTopicOutput {
    var result: DescribeTopicOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeTopicOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
