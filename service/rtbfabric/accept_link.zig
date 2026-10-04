const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinkAttributes = @import("link_attributes.zig").LinkAttributes;
const LinkLogSettings = @import("link_log_settings.zig").LinkLogSettings;
const ConnectivityType = @import("connectivity_type.zig").ConnectivityType;
const LinkDirection = @import("link_direction.zig").LinkDirection;
const ModuleConfiguration = @import("module_configuration.zig").ModuleConfiguration;
const LinkStatus = @import("link_status.zig").LinkStatus;

pub const AcceptLinkInput = struct {
    /// Attributes of the link.
    attributes: ?LinkAttributes = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifier of the link.
    link_id: []const u8,

    /// Settings for the application logs.
    log_settings: LinkLogSettings,

    /// The timeout value in milliseconds.
    timeout_in_millis: ?i64 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .gateway_id = "gatewayId",
        .link_id = "linkId",
        .log_settings = "logSettings",
        .timeout_in_millis = "timeoutInMillis",
    };
};

pub const AcceptLinkOutput = struct {
    /// Attributes of the link.
    attributes: ?LinkAttributes = null,

    /// The connectivity type of the link.
    connectivity_type: ?ConnectivityType = null,

    /// The timestamp of when the link was created.
    created_at: i64,

    /// The direction of the link.
    direction: ?LinkDirection = null,

    /// The configuration of flow modules.
    flow_modules: ?[]const ModuleConfiguration = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifier of the link.
    link_id: []const u8,

    log_settings: ?LinkLogSettings = null,

    /// The unique identifier of the peer gateway.
    peer_gateway_id: []const u8,

    /// The configuration of pending flow modules.
    pending_flow_modules: ?[]const ModuleConfiguration = null,

    /// The status of the link.
    status: LinkStatus,

    /// The timestamp of when the link was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .attributes = "attributes",
        .connectivity_type = "connectivityType",
        .created_at = "createdAt",
        .direction = "direction",
        .flow_modules = "flowModules",
        .gateway_id = "gatewayId",
        .link_id = "linkId",
        .log_settings = "logSettings",
        .peer_gateway_id = "peerGatewayId",
        .pending_flow_modules = "pendingFlowModules",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptLinkInput, options: CallOptions) !AcceptLinkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rtbfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    try path_buf.appendSlice(allocator, "/link/");
    try path_buf.appendSlice(allocator, input.link_id);
    try path_buf.appendSlice(allocator, "/accept");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"logSettings\":");
    try aws.json.writeValue(@TypeOf(input.log_settings), input.log_settings, allocator, &body_buf);
    has_prev = true;
    if (input.timeout_in_millis) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeoutInMillis\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptLinkOutput {
    var result: AcceptLinkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AcceptLinkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
