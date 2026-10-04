const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RebootBrokerInput = struct {
    /// The list of broker IDs to be rebooted. The reboot-broker operation supports
    /// rebooting one broker at a time.
    broker_ids: []const []const u8,

    /// The Amazon Resource Name (ARN) of the cluster to be updated.
    cluster_arn: []const u8,

    pub const json_field_names = .{
        .broker_ids = "BrokerIds",
        .cluster_arn = "ClusterArn",
    };
};

pub const RebootBrokerOutput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the cluster operation.
    cluster_operation_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_operation_arn = "ClusterOperationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RebootBrokerInput, options: CallOptions) !RebootBrokerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RebootBrokerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_arn);
    try path_buf.appendSlice(allocator, "/reboot-broker");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BrokerIds\":");
    try aws.json.writeValue(@TypeOf(input.broker_ids), input.broker_ids, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RebootBrokerOutput {
    var result: RebootBrokerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RebootBrokerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
