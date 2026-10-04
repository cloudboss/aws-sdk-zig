const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateEgressGatewayBridgeRequest = @import("update_egress_gateway_bridge_request.zig").UpdateEgressGatewayBridgeRequest;
const UpdateIngressGatewayBridgeRequest = @import("update_ingress_gateway_bridge_request.zig").UpdateIngressGatewayBridgeRequest;
const UpdateFailoverConfig = @import("update_failover_config.zig").UpdateFailoverConfig;
const Bridge = @import("bridge.zig").Bridge;

pub const UpdateBridgeInput = struct {
    /// TheAmazon Resource Name (ARN) of the bridge that you want to update.
    bridge_arn: []const u8,

    /// A cloud-to-ground bridge. The content comes from an existing MediaConnect
    /// flow and is delivered to your premises.
    egress_gateway_bridge: ?UpdateEgressGatewayBridgeRequest = null,

    /// A ground-to-cloud bridge. The content originates at your premises and is
    /// delivered to the cloud.
    ingress_gateway_bridge: ?UpdateIngressGatewayBridgeRequest = null,

    /// The settings for source failover.
    source_failover_config: ?UpdateFailoverConfig = null,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .egress_gateway_bridge = "EgressGatewayBridge",
        .ingress_gateway_bridge = "IngressGatewayBridge",
        .source_failover_config = "SourceFailoverConfig",
    };
};

pub const UpdateBridgeOutput = @import("update_bridge_response.zig").UpdateBridgeResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBridgeInput, options: CallOptions) !UpdateBridgeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBridgeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/bridges/");
    try path_buf.appendSlice(allocator, input.bridge_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.egress_gateway_bridge) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EgressGatewayBridge\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ingress_gateway_bridge) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IngressGatewayBridge\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_failover_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceFailoverConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBridgeOutput {
    var result: UpdateBridgeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateBridgeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
