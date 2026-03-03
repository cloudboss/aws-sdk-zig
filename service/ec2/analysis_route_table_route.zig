/// Describes a route table route.
pub const AnalysisRouteTableRoute = struct {
    /// The ID of a carrier gateway.
    carrier_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a core network.
    core_network_arn: ?[]const u8 = null,

    /// The destination IPv4 address, in CIDR notation.
    destination_cidr: ?[]const u8 = null,

    /// The prefix of the Amazon Web Services service.
    destination_prefix_list_id: ?[]const u8 = null,

    /// The ID of an egress-only internet gateway.
    egress_only_internet_gateway_id: ?[]const u8 = null,

    /// The ID of the gateway, such as an internet gateway or virtual private
    /// gateway.
    gateway_id: ?[]const u8 = null,

    /// The ID of the instance, such as a NAT instance.
    instance_id: ?[]const u8 = null,

    /// The ID of a local gateway.
    local_gateway_id: ?[]const u8 = null,

    /// The ID of a NAT gateway.
    nat_gateway_id: ?[]const u8 = null,

    /// The ID of a network interface.
    network_interface_id: ?[]const u8 = null,

    /// Describes how the route was created. The following are the possible values:
    ///
    /// * CreateRouteTable - The route was automatically created when the route
    ///   table was created.
    ///
    /// * CreateRoute - The route was manually added to the route table.
    ///
    /// * EnableVgwRoutePropagation - The route was propagated by route propagation.
    origin: ?[]const u8 = null,

    /// The state. The following are the possible values:
    ///
    /// * active
    ///
    /// * blackhole
    state: ?[]const u8 = null,

    /// The ID of a transit gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of a VPC peering connection.
    vpc_peering_connection_id: ?[]const u8 = null,
};
