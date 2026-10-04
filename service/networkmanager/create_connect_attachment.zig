const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectAttachmentOptions = @import("connect_attachment_options.zig").ConnectAttachmentOptions;
const Tag = @import("tag.zig").Tag;
const ConnectAttachment = @import("connect_attachment.zig").ConnectAttachment;

pub const CreateConnectAttachmentInput = struct {
    /// The client token associated with the request.
    client_token: ?[]const u8 = null,

    /// The ID of a core network where you want to create the attachment.
    core_network_id: []const u8,

    /// The Region where the edge is located.
    edge_location: []const u8,

    /// Options for creating an attachment.
    options: ConnectAttachmentOptions,

    /// The routing policy label to apply to the Connect attachment for traffic
    /// routing decisions.
    routing_policy_label: ?[]const u8 = null,

    /// The list of key-value tags associated with the request.
    tags: ?[]const Tag = null,

    /// The ID of the attachment between the two connections.
    transport_attachment_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .core_network_id = "CoreNetworkId",
        .edge_location = "EdgeLocation",
        .options = "Options",
        .routing_policy_label = "RoutingPolicyLabel",
        .tags = "Tags",
        .transport_attachment_id = "TransportAttachmentId",
    };
};

pub const CreateConnectAttachmentOutput = struct {
    /// The response to a Connect attachment request.
    connect_attachment: ?ConnectAttachment = null,

    pub const json_field_names = .{
        .connect_attachment = "ConnectAttachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectAttachmentInput, options: CallOptions) !CreateConnectAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connect-attachments";

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
    try body_buf.appendSlice(allocator, "\"EdgeLocation\":");
    try aws.json.writeValue(@TypeOf(input.edge_location), input.edge_location, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Options\":");
    try aws.json.writeValue(@TypeOf(input.options), input.options, allocator, &body_buf);
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TransportAttachmentId\":");
    try aws.json.writeValue(@TypeOf(input.transport_attachment_id), input.transport_attachment_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectAttachmentOutput {
    var result: CreateConnectAttachmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConnectAttachmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
