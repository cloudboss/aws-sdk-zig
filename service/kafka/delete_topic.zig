const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TopicState = @import("topic_state.zig").TopicState;

pub const DeleteTopicInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: []const u8,

    /// The name of the topic to delete.
    topic_name: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .topic_name = "TopicName",
    };
};

pub const DeleteTopicOutput = struct {
    /// The status of the topic deletion.
    status: ?TopicState = null,

    /// The Amazon Resource Name (ARN) of the topic.
    topic_arn: ?[]const u8 = null,

    /// The name of the topic that was deleted.
    topic_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
        .topic_arn = "TopicArn",
        .topic_name = "TopicName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteTopicInput, options: CallOptions) !DeleteTopicOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteTopicInput, config: *aws.Config) !aws.http.Request {
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
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteTopicOutput {
    var result: DeleteTopicOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteTopicOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
