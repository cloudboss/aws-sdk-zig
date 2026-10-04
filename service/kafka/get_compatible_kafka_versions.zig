const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompatibleKafkaVersion = @import("compatible_kafka_version.zig").CompatibleKafkaVersion;

pub const GetCompatibleKafkaVersionsInput = struct {
    /// The Amazon Resource Name (ARN) of the cluster check.
    cluster_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
    };
};

pub const GetCompatibleKafkaVersionsOutput = struct {
    /// A list of CompatibleKafkaVersion objects.
    compatible_kafka_versions: ?[]const CompatibleKafkaVersion = null,

    pub const json_field_names = .{
        .compatible_kafka_versions = "CompatibleKafkaVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCompatibleKafkaVersionsInput, options: CallOptions) !GetCompatibleKafkaVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCompatibleKafkaVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/compatible-kafka-versions";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.cluster_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clusterArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCompatibleKafkaVersionsOutput {
    const result: GetCompatibleKafkaVersionsOutput = try aws.json.parseJsonObject(
        GetCompatibleKafkaVersionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
