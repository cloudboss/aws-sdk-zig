const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinkAttributes = @import("link_attributes.zig").LinkAttributes;
const ConnectivityType = @import("connectivity_type.zig").ConnectivityType;
const LinkDirection = @import("link_direction.zig").LinkDirection;
const ModuleConfiguration = @import("module_configuration.zig").ModuleConfiguration;
const LinkLogSettings = @import("link_log_settings.zig").LinkLogSettings;
const LinkStatus = @import("link_status.zig").LinkStatus;

pub const RejectLinkInput = struct {
    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifier of the link.
    link_id: []const u8,

    pub const json_field_names = .{
        .gateway_id = "gatewayId",
        .link_id = "linkId",
    };
};

pub const RejectLinkOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RejectLinkInput, options: CallOptions) !RejectLinkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RejectLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    try path_buf.appendSlice(allocator, "/link/");
    try path_buf.appendSlice(allocator, input.link_id);
    try path_buf.appendSlice(allocator, "/reject");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RejectLinkOutput {
    const result: RejectLinkOutput = try aws.json.parseJsonObject(
        RejectLinkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
