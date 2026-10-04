const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListenerConfig = @import("listener_config.zig").ListenerConfig;
const ManagedEndpointConfiguration = @import("managed_endpoint_configuration.zig").ManagedEndpointConfiguration;
const Protocol = @import("protocol.zig").Protocol;
const TrustStoreConfiguration = @import("trust_store_configuration.zig").TrustStoreConfiguration;
const ResponderGatewayStatus = @import("responder_gateway_status.zig").ResponderGatewayStatus;

pub const UpdateResponderGatewayInput = struct {
    /// The unique client token.
    client_token: []const u8,

    /// An optional description for the responder gateway.
    description: ?[]const u8 = null,

    /// The domain name for the responder gateway.
    domain_name: ?[]const u8 = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The listener configuration for the responder gateway.
    listener_config: ?ListenerConfig = null,

    /// The configuration for the managed endpoint.
    managed_endpoint_configuration: ?ManagedEndpointConfiguration = null,

    /// The networking port to use.
    port: i32,

    /// The networking protocol to use.
    protocol: Protocol,

    /// The configuration of the trust store.
    trust_store_configuration: ?TrustStoreConfiguration = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .domain_name = "domainName",
        .gateway_id = "gatewayId",
        .listener_config = "listenerConfig",
        .managed_endpoint_configuration = "managedEndpointConfiguration",
        .port = "port",
        .protocol = "protocol",
        .trust_store_configuration = "trustStoreConfiguration",
    };
};

pub const UpdateResponderGatewayOutput = struct {
    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The status of the request.
    status: ResponderGatewayStatus,

    pub const json_field_names = .{
        .gateway_id = "gatewayId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResponderGatewayInput, options: CallOptions) !UpdateResponderGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResponderGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/responder-gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    try path_buf.appendSlice(allocator, "/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.listener_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"listenerConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.managed_endpoint_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"managedEndpointConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"port\":");
    try aws.json.writeValue(@TypeOf(input.port), input.port, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"protocol\":");
    try aws.json.writeValue(@TypeOf(input.protocol), input.protocol, allocator, &body_buf);
    has_prev = true;
    if (input.trust_store_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"trustStoreConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResponderGatewayOutput {
    var result: UpdateResponderGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateResponderGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
