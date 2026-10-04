const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinkAttributes = @import("link_attributes.zig").LinkAttributes;
const ConnectivityType = @import("connectivity_type.zig").ConnectivityType;
const ModuleConfiguration = @import("module_configuration.zig").ModuleConfiguration;
const LinkLogSettings = @import("link_log_settings.zig").LinkLogSettings;
const LinkStatus = @import("link_status.zig").LinkStatus;

pub const GetOutboundExternalLinkInput = struct {
    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifier of the link.
    link_id: []const u8,

    pub const json_field_names = .{
        .gateway_id = "gatewayId",
        .link_id = "linkId",
    };
};

pub const GetOutboundExternalLinkOutput = struct {
    attributes: ?LinkAttributes = null,

    /// The connectivity type of the link.
    connectivity_type: ?ConnectivityType = null,

    /// The timestamp of when the outbound external link was created.
    created_at: ?i64 = null,

    /// The configuration of flow modules.
    flow_modules: ?[]const ModuleConfiguration = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifier of the link.
    link_id: []const u8,

    /// Settings for the application logs.
    log_settings: ?LinkLogSettings = null,

    /// The configuration of pending flow modules.
    pending_flow_modules: ?[]const ModuleConfiguration = null,

    /// The public endpoint for the link.
    public_endpoint: []const u8,

    /// The status of the request.
    status: LinkStatus,

    /// A map of the key-value pairs for the tag or tags assigned to the specified
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp of when the outbound external link was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .connectivity_type = "connectivityType",
        .created_at = "createdAt",
        .flow_modules = "flowModules",
        .gateway_id = "gatewayId",
        .link_id = "linkId",
        .log_settings = "logSettings",
        .pending_flow_modules = "pendingFlowModules",
        .public_endpoint = "publicEndpoint",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOutboundExternalLinkInput, options: CallOptions) !GetOutboundExternalLinkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOutboundExternalLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/requester-gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    try path_buf.appendSlice(allocator, "/outbound-external-link/");
    try path_buf.appendSlice(allocator, input.link_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOutboundExternalLinkOutput {
    const result: GetOutboundExternalLinkOutput = try aws.json.parseJsonObject(
        GetOutboundExternalLinkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
