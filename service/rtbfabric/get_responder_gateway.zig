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
const ResponderGatewayStatus = @import("responder_gateway_status.zig").ResponderGatewayStatus;
const TrustStoreConfiguration = @import("trust_store_configuration.zig").TrustStoreConfiguration;

pub const GetResponderGatewayInput = struct {
    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    pub const json_field_names = .{
        .gateway_id = "gatewayId",
    };
};

pub const GetResponderGatewayOutput = struct {
    /// The count of active links for the responder gateway.
    active_links_count: ?i32 = null,

    /// The client routing policy of the gateway. This policy controls which
    /// Availability Zones RTB Fabric uses to reach the gateway for the requester
    /// gateways that send traffic to it. RTB Fabric omits this member if the
    /// gateway has never had a client routing policy. An omitted value means that
    /// the gateway uses `AVAILABILITY_ZONE_AFFINITY`. For more information, see
    /// [Configuring Availability Zone
    /// affinity](https://docs.aws.amazon.com/rtb-fabric/latest/userguide/working-with-responder-gateways.html#configuring-availability-zone-affinity) in the *Amazon Web Services RTB Fabric User Guide*.
    client_routing_policy: ?ClientRoutingPolicy = null,

    /// The timestamp of when the responder gateway was created.
    created_at: ?i64 = null,

    /// The description of the responder gateway.
    description: ?[]const u8 = null,

    /// The domain name of the responder gateway.
    domain_name: ?[]const u8 = null,

    /// The external inbound endpoint for the responder gateway.
    external_inbound_endpoint: ?[]const u8 = null,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The type of gateway. Valid values are `EXTERNAL` or `INTERNAL`.
    gateway_type: ?GatewayType = null,

    /// The count of requested links waiting for the responder gateway to accept or
    /// reject.
    links_requested_count: ?i32 = null,

    /// The listener configuration for the responder gateway.
    listener_config: ?ListenerConfig = null,

    /// The configuration of the managed endpoint.
    managed_endpoint_configuration: ?ManagedEndpointConfiguration = null,

    /// The networking port.
    port: i32,

    /// The networking protocol.
    protocol: Protocol,

    /// The unique identifiers of the security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// The status of the request.
    status: ResponderGatewayStatus,

    /// The unique identifiers of the subnets.
    subnet_ids: ?[]const []const u8 = null,

    /// A map of the key-value pairs for the tag or tags assigned to the specified
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The total count of links for the responder gateway.
    total_links_count: ?i32 = null,

    /// The configuration of the trust store.
    trust_store_configuration: ?TrustStoreConfiguration = null,

    /// The timestamp of when the responder gateway was updated.
    updated_at: ?i64 = null,

    /// The unique identifier of the Virtual Private Cloud (VPC).
    vpc_id: []const u8,

    pub const json_field_names = .{
        .active_links_count = "activeLinksCount",
        .client_routing_policy = "clientRoutingPolicy",
        .created_at = "createdAt",
        .description = "description",
        .domain_name = "domainName",
        .external_inbound_endpoint = "externalInboundEndpoint",
        .gateway_id = "gatewayId",
        .gateway_type = "gatewayType",
        .links_requested_count = "linksRequestedCount",
        .listener_config = "listenerConfig",
        .managed_endpoint_configuration = "managedEndpointConfiguration",
        .port = "port",
        .protocol = "protocol",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .total_links_count = "totalLinksCount",
        .trust_store_configuration = "trustStoreConfiguration",
        .updated_at = "updatedAt",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResponderGatewayInput, options: CallOptions) !GetResponderGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResponderGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/responder-gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResponderGatewayOutput {
    const result: GetResponderGatewayOutput = try aws.json.parseJsonObject(
        GetResponderGatewayOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
