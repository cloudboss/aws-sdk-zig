const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GatewayType = @import("gateway_type.zig").GatewayType;
const ListenerConfig = @import("listener_config.zig").ListenerConfig;
const ManagedEndpointConfiguration = @import("managed_endpoint_configuration.zig").ManagedEndpointConfiguration;
const Protocol = @import("protocol.zig").Protocol;
const TrustStoreConfiguration = @import("trust_store_configuration.zig").TrustStoreConfiguration;
const ResponderGatewayStatus = @import("responder_gateway_status.zig").ResponderGatewayStatus;

pub const CreateResponderGatewayInput = struct {
    /// The unique client token.
    client_token: []const u8,

    /// An optional description for the responder gateway.
    description: ?[]const u8 = null,

    /// The domain name for the responder gateway.
    domain_name: ?[]const u8 = null,

    /// The type of gateway. Valid values are `EXTERNAL` or `INTERNAL`.
    gateway_type: ?GatewayType = null,

    listener_config: ?ListenerConfig = null,

    /// The configuration for the managed endpoint.
    managed_endpoint_configuration: ?ManagedEndpointConfiguration = null,

    /// The networking port to use.
    port: i32,

    /// The networking protocol to use.
    protocol: Protocol,

    /// The unique identifiers of the security groups.
    security_group_ids: []const []const u8,

    /// The unique identifiers of the subnets.
    subnet_ids: []const []const u8,

    /// A map of the key-value pairs of the tag or tags to assign to the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration of the trust store.
    trust_store_configuration: ?TrustStoreConfiguration = null,

    /// The unique identifier of the Virtual Private Cloud (VPC).
    vpc_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .domain_name = "domainName",
        .gateway_type = "gatewayType",
        .listener_config = "listenerConfig",
        .managed_endpoint_configuration = "managedEndpointConfiguration",
        .port = "port",
        .protocol = "protocol",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .trust_store_configuration = "trustStoreConfiguration",
        .vpc_id = "vpcId",
    };
};

pub const CreateResponderGatewayOutput = struct {
    /// The external inbound endpoint for the responder gateway.
    external_inbound_endpoint: ?[]const u8 = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The listener configuration for the responder gateway.
    listener_config: ?ListenerConfig = null,

    /// The status of the request.
    status: ResponderGatewayStatus,

    pub const json_field_names = .{
        .external_inbound_endpoint = "externalInboundEndpoint",
        .gateway_id = "gatewayId",
        .listener_config = "listenerConfig",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResponderGatewayInput, options: CallOptions) !CreateResponderGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResponderGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/responder-gateway";

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
    if (input.gateway_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"gatewayType\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"securityGroupIds\":");
    try aws.json.writeValue(@TypeOf(input.security_group_ids), input.security_group_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subnetIds\":");
    try aws.json.writeValue(@TypeOf(input.subnet_ids), input.subnet_ids, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.trust_store_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"trustStoreConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"vpcId\":");
    try aws.json.writeValue(@TypeOf(input.vpc_id), input.vpc_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResponderGatewayOutput {
    var result: CreateResponderGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateResponderGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
