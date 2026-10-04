const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkType = @import("network_type.zig").NetworkType;
const Cluster = @import("cluster.zig").Cluster;

pub const UpdateClusterInput = struct {
    /// The Amazon Resource Name (ARN) of the cluster.
    cluster_arn: []const u8,

    /// The network type of the cluster. NetworkType can be one of the following:
    /// IPV4, DUALSTACK.
    network_type: NetworkType,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .network_type = "NetworkType",
    };
};

pub const UpdateClusterOutput = struct {
    /// The cluster that was updated.
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-control-config", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("route53-recovery-control-config", "Route53 Recovery Control Config", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cluster";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClusterArn\":");
    try aws.json.writeValue(@TypeOf(input.cluster_arn), input.cluster_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NetworkType\":");
    try aws.json.writeValue(@TypeOf(input.network_type), input.network_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterOutput {
    var result: UpdateClusterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateClusterOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
