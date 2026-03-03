const RouteOrigin = @import("route_origin.zig").RouteOrigin;
const RouteState = @import("route_state.zig").RouteState;

/// Describes a route in a route table.
pub const Route = struct {
    /// The ID of the carrier gateway.
    carrier_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the core network.
    core_network_arn: ?[]const u8 = null,

    /// The IPv4 CIDR block used for the destination match.
    destination_cidr_block: ?[]const u8 = null,

    /// The IPv6 CIDR block used for the destination match.
    destination_ipv_6_cidr_block: ?[]const u8 = null,

    /// The prefix of the Amazon Web Services service.
    destination_prefix_list_id: ?[]const u8 = null,

    /// The ID of the egress-only internet gateway.
    egress_only_internet_gateway_id: ?[]const u8 = null,

    /// The ID of a gateway attached to your VPC.
    gateway_id: ?[]const u8 = null,

    /// The ID of a NAT instance in your VPC.
    instance_id: ?[]const u8 = null,

    /// The ID of Amazon Web Services account that owns the instance.
    instance_owner_id: ?[]const u8 = null,

    /// The next hop IP address for routes propagated by VPC Route
    /// Server into VPC route tables.
    ip_address: ?[]const u8 = null,

    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8 = null,

    /// The ID of a NAT gateway.
    nat_gateway_id: ?[]const u8 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the ODB network.
    odb_network_arn: ?[]const u8 = null,

    /// Describes how the route was created.
    ///
    /// * `CreateRouteTable` - The route was automatically created when the route
    ///   table was created.
    ///
    /// * `CreateRoute` - The route was manually added to the route table.
    ///
    /// * `EnableVgwRoutePropagation` - The route was propagated by route
    ///   propagation.
    ///
    /// * `Advertisement` - The route was created dynamically by Amazon VPC Route
    ///   Server.
    origin: ?RouteOrigin = null,

    /// The state of the route. The `blackhole` state indicates that the
    /// route's target isn't available (for example, the specified gateway isn't
    /// attached to the
    /// VPC, or the specified NAT instance has been terminated).
    state: ?RouteState = null,

    /// The ID of a transit gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of a VPC peering connection.
    vpc_peering_connection_id: ?[]const u8 = null,
};
