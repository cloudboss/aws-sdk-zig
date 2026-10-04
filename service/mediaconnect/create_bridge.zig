const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddEgressGatewayBridgeRequest = @import("add_egress_gateway_bridge_request.zig").AddEgressGatewayBridgeRequest;
const AddIngressGatewayBridgeRequest = @import("add_ingress_gateway_bridge_request.zig").AddIngressGatewayBridgeRequest;
const AddBridgeOutputRequest = @import("add_bridge_output_request.zig").AddBridgeOutputRequest;
const FailoverConfig = @import("failover_config.zig").FailoverConfig;
const AddBridgeSourceRequest = @import("add_bridge_source_request.zig").AddBridgeSourceRequest;
const Bridge = @import("bridge.zig").Bridge;

pub const CreateBridgeInput = struct {
    /// An egress bridge is a cloud-to-ground bridge. The content comes from an
    /// existing MediaConnect flow and is delivered to your premises.
    egress_gateway_bridge: ?AddEgressGatewayBridgeRequest = null,

    /// An ingress bridge is a ground-to-cloud bridge. The content originates at
    /// your premises and is delivered to the cloud.
    ingress_gateway_bridge: ?AddIngressGatewayBridgeRequest = null,

    /// The name of the bridge. This name can not be modified after the bridge is
    /// created.
    name: []const u8,

    /// The outputs that you want to add to this bridge.
    outputs: ?[]const AddBridgeOutputRequest = null,

    /// The bridge placement Amazon Resource Number (ARN).
    placement_arn: []const u8,

    /// The settings for source failover.
    source_failover_config: ?FailoverConfig = null,

    /// The sources that you want to add to this bridge.
    sources: []const AddBridgeSourceRequest,

    pub const json_field_names = .{
        .egress_gateway_bridge = "EgressGatewayBridge",
        .ingress_gateway_bridge = "IngressGatewayBridge",
        .name = "Name",
        .outputs = "Outputs",
        .placement_arn = "PlacementArn",
        .source_failover_config = "SourceFailoverConfig",
        .sources = "Sources",
    };
};

pub const CreateBridgeOutput = struct {
    /// The name of the bridge that was created.
    bridge: ?Bridge = null,

    pub const json_field_names = .{
        .bridge = "Bridge",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBridgeInput, options: CallOptions) !CreateBridgeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBridgeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/bridges";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.outputs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Outputs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PlacementArn\":");
    try aws.json.writeValue(@TypeOf(input.placement_arn), input.placement_arn, allocator, &body_buf);
    has_prev = true;
    if (input.source_failover_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceFailoverConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Sources\":");
    try aws.json.writeValue(@TypeOf(input.sources), input.sources, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBridgeOutput {
    var result: CreateBridgeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBridgeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
