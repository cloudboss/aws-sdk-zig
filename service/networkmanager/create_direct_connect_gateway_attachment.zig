const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DirectConnectGatewayAttachment = @import("direct_connect_gateway_attachment.zig").DirectConnectGatewayAttachment;

pub const CreateDirectConnectGatewayAttachmentInput = struct {
    /// client token
    client_token: ?[]const u8 = null,

    /// The ID of the Cloud WAN core network that the Direct Connect gateway
    /// attachment should be attached to.
    core_network_id: []const u8,

    /// The ARN of the Direct Connect gateway attachment.
    direct_connect_gateway_arn: []const u8,

    /// One or more core network edge locations that the Direct Connect gateway
    /// attachment is associated with.
    edge_locations: []const []const u8,

    /// The routing policy label to apply to the Direct Connect Gateway attachment
    /// for traffic routing decisions.
    routing_policy_label: ?[]const u8 = null,

    /// The key value tags to apply to the Direct Connect gateway attachment during
    /// creation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .core_network_id = "CoreNetworkId",
        .direct_connect_gateway_arn = "DirectConnectGatewayArn",
        .edge_locations = "EdgeLocations",
        .routing_policy_label = "RoutingPolicyLabel",
        .tags = "Tags",
    };
};

pub const CreateDirectConnectGatewayAttachmentOutput = struct {
    /// Describes the details of a `CreateDirectConnectGatewayAttachment` request.
    direct_connect_gateway_attachment: ?DirectConnectGatewayAttachment = null,

    pub const json_field_names = .{
        .direct_connect_gateway_attachment = "DirectConnectGatewayAttachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDirectConnectGatewayAttachmentInput, options: CallOptions) !CreateDirectConnectGatewayAttachmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDirectConnectGatewayAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/direct-connect-gateway-attachments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CoreNetworkId\":");
    try aws.json.writeValue(@TypeOf(input.core_network_id), input.core_network_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DirectConnectGatewayArn\":");
    try aws.json.writeValue(@TypeOf(input.direct_connect_gateway_arn), input.direct_connect_gateway_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EdgeLocations\":");
    try aws.json.writeValue(@TypeOf(input.edge_locations), input.edge_locations, allocator, &body_buf);
    has_prev = true;
    if (input.routing_policy_label) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoutingPolicyLabel\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDirectConnectGatewayAttachmentOutput {
    const result: CreateDirectConnectGatewayAttachmentOutput = try aws.json.parseJsonObject(
        CreateDirectConnectGatewayAttachmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
