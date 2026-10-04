const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisionedRequest = @import("provisioned_request.zig").ProvisionedRequest;
const ServerlessRequest = @import("serverless_request.zig").ServerlessRequest;
const ClusterType = @import("cluster_type.zig").ClusterType;
const ClusterState = @import("cluster_state.zig").ClusterState;

pub const CreateClusterV2Input = struct {
    /// The name of the cluster.
    cluster_name: []const u8,

    /// Information about the provisioned cluster.
    provisioned: ?ProvisionedRequest = null,

    /// Information about the serverless cluster.
    serverless: ?ServerlessRequest = null,

    /// A map of tags that you want the cluster to have.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .provisioned = "Provisioned",
        .serverless = "Serverless",
        .tags = "Tags",
    };
};

pub const CreateClusterV2Output = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// The name of the MSK cluster.
    cluster_name: ?[]const u8 = null,

    /// The type of the cluster. The possible states are PROVISIONED or SERVERLESS.
    cluster_type: ?ClusterType = null,

    /// The state of the cluster. The possible states are ACTIVE, CREATING,
    /// DELETING, FAILED, HEALING, MAINTENANCE, REBOOTING_BROKER, and UPDATING.
    state: ?ClusterState = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_name = "ClusterName",
        .cluster_type = "ClusterType",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterV2Input, options: CallOptions) !CreateClusterV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/api/v2/clusters";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClusterName\":");
    try aws.json.writeValue(@TypeOf(input.cluster_name), input.cluster_name, allocator, &body_buf);
    has_prev = true;
    if (input.provisioned) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Provisioned\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.serverless) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Serverless\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterV2Output {
    var result: CreateClusterV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateClusterV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
