const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientRoutingPolicy = @import("client_routing_policy.zig").ClientRoutingPolicy;
const GatewayType = @import("gateway_type.zig").GatewayType;
const ListenerConfig = @import("listener_config.zig").ListenerConfig;
const ManagedEndpointConfiguration = @import("managed_endpoint_configuration.zig").ManagedEndpointConfiguration;
const Protocol = @import("protocol.zig").Protocol;
const TrustStoreConfiguration = @import("trust_store_configuration.zig").TrustStoreConfiguration;
const ResponderGatewayStatus = @import("responder_gateway_status.zig").ResponderGatewayStatus;

pub const CreateResponderGatewayInput = struct {
    /// The client routing policy of the gateway. This policy controls which
    /// Availability Zones RTB Fabric uses to reach the gateway for the requester
    /// gateways that send traffic to it. Valid values are the following:
    ///
    /// * `AVAILABILITY_ZONE_AFFINITY`: RTB Fabric routes each requester's traffic
    ///   to gateway capacity in the requester's own Availability Zone when the
    ///   gateway has capacity available there. Otherwise, RTB Fabric routes the
    ///   traffic to gateway capacity in the other Availability Zones of the
    ///   gateway.
    /// * `ANY_AVAILABILITY_ZONE`: RTB Fabric routes each requester's traffic to
    ///   gateway capacity in every Availability Zone that the subnets of the
    ///   gateway span. The Availability Zone that the requester is in does not
    ///   change this.
    ///
    /// If you don't specify a value, RTB Fabric uses `AVAILABILITY_ZONE_AFFINITY`.
    /// To get the behavior of `ANY_AVAILABILITY_ZONE`, create the gateway with
    /// subnets in more than one Availability Zone. RTB Fabric does not support
    /// partial Availability Zone affinity, so `PARTIAL_AVAILABILITY_ZONE_AFFINITY`
    /// is not a valid value. For more information, see [Configuring Availability
    /// Zone
    /// affinity](https://docs.aws.amazon.com/rtb-fabric/latest/userguide/working-with-responder-gateways.html#configuring-availability-zone-affinity) in the *Amazon Web Services RTB Fabric User Guide*.
    client_routing_policy: ?ClientRoutingPolicy = null,

    /// Specifies a unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. This lets you safely retry the request without
    /// accidentally performing the same operation a second time. Passing the same
    /// value to a later call to an operation requires that you also pass the same
    /// value for all other parameters. We recommend that you use a [UUID type of
    /// value](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for you.
    ///
    /// If you retry the operation with the same `clientToken`, but with different
    /// parameters, the retry fails with an `IdempotentParameterMismatch` error.
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

    /// Unique identifiers of the subnets. A service quota for your account sets the
    /// number of Availability Zones that your subnets can span. By default, this
    /// quota is one Availability Zone. To span more Availability Zones, request a
    /// quota increase.
    subnet_ids: []const []const u8,

    /// A map of the key-value pairs of the tag or tags to assign to the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The configuration of the trust store.
    trust_store_configuration: ?TrustStoreConfiguration = null,

    /// The unique identifier of the Virtual Private Cloud (VPC).
    vpc_id: []const u8,

    pub const json_field_names = .{
        .client_routing_policy = "clientRoutingPolicy",
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
    /// The client routing policy of the gateway. This policy controls which
    /// Availability Zones RTB Fabric uses to reach the gateway for the requester
    /// gateways that send traffic to it. For more information, see [Configuring
    /// Availability Zone
    /// affinity](https://docs.aws.amazon.com/rtb-fabric/latest/userguide/working-with-responder-gateways.html#configuring-availability-zone-affinity) in the *Amazon Web Services RTB Fabric User Guide*.
    client_routing_policy: ?ClientRoutingPolicy = null,

    /// The external inbound endpoint for the responder gateway.
    external_inbound_endpoint: ?[]const u8 = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The listener configuration for the responder gateway.
    listener_config: ?ListenerConfig = null,

    /// The status of the request.
    status: ResponderGatewayStatus,

    pub const json_field_names = .{
        .client_routing_policy = "clientRoutingPolicy",
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

    if (input.client_routing_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRoutingPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    const result: CreateResponderGatewayOutput = try aws.json.parseJsonObject(
        CreateResponderGatewayOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
