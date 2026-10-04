const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutAttachmentRoutingPolicyLabelInput = struct {
    /// The ID of the attachment to apply the routing policy label to.
    attachment_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the core network containing the attachment.
    core_network_id: []const u8,

    /// The routing policy label to apply to the attachment.
    routing_policy_label: []const u8,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .client_token = "ClientToken",
        .core_network_id = "CoreNetworkId",
        .routing_policy_label = "RoutingPolicyLabel",
    };
};

pub const PutAttachmentRoutingPolicyLabelOutput = struct {
    /// The ID of the attachment that received the routing policy label.
    attachment_id: ?[]const u8 = null,

    /// The ID of the core network containing the attachment.
    core_network_id: ?[]const u8 = null,

    /// The routing policy label that was applied to the attachment.
    routing_policy_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .core_network_id = "CoreNetworkId",
        .routing_policy_label = "RoutingPolicyLabel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAttachmentRoutingPolicyLabelInput, options: CallOptions) !PutAttachmentRoutingPolicyLabelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAttachmentRoutingPolicyLabelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/routing-policy-label";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AttachmentId\":");
    try aws.json.writeValue(@TypeOf(input.attachment_id), input.attachment_id, allocator, &body_buf);
    has_prev = true;
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
    try body_buf.appendSlice(allocator, "\"RoutingPolicyLabel\":");
    try aws.json.writeValue(@TypeOf(input.routing_policy_label), input.routing_policy_label, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAttachmentRoutingPolicyLabelOutput {
    const result: PutAttachmentRoutingPolicyLabelOutput = try aws.json.parseJsonObject(
        PutAttachmentRoutingPolicyLabelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
