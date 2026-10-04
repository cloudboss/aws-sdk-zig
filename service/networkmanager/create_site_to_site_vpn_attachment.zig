const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const SiteToSiteVpnAttachment = @import("site_to_site_vpn_attachment.zig").SiteToSiteVpnAttachment;

pub const CreateSiteToSiteVpnAttachmentInput = struct {
    /// The client token associated with the request.
    client_token: ?[]const u8 = null,

    /// The ID of a core network where you're creating a site-to-site VPN
    /// attachment.
    core_network_id: []const u8,

    /// The routing policy label to apply to the Site-to-Site VPN attachment for
    /// traffic routing decisions.
    routing_policy_label: ?[]const u8 = null,

    /// The tags associated with the request.
    tags: ?[]const Tag = null,

    /// The ARN identifying the VPN attachment.
    vpn_connection_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .core_network_id = "CoreNetworkId",
        .routing_policy_label = "RoutingPolicyLabel",
        .tags = "Tags",
        .vpn_connection_arn = "VpnConnectionArn",
    };
};

pub const CreateSiteToSiteVpnAttachmentOutput = struct {
    /// Details about a site-to-site VPN attachment.
    site_to_site_vpn_attachment: ?SiteToSiteVpnAttachment = null,

    pub const json_field_names = .{
        .site_to_site_vpn_attachment = "SiteToSiteVpnAttachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSiteToSiteVpnAttachmentInput, options: CallOptions) !CreateSiteToSiteVpnAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSiteToSiteVpnAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/site-to-site-vpn-attachments";

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
    try body_buf.appendSlice(allocator, "\"VpnConnectionArn\":");
    try aws.json.writeValue(@TypeOf(input.vpn_connection_arn), input.vpn_connection_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSiteToSiteVpnAttachmentOutput {
    var result: CreateSiteToSiteVpnAttachmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSiteToSiteVpnAttachmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
