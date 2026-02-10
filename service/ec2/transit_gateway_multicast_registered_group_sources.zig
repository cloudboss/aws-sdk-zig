/// Describes the members registered with the transit gateway multicast group.
pub const TransitGatewayMulticastRegisteredGroupSources = struct {
    /// The IP address assigned to the transit gateway multicast group.
    group_ip_address: ?[]const u8,

    /// The IDs of the network interfaces members registered with the transit
    /// gateway multicast group.
    registered_network_interface_ids: ?[]const []const u8,

    /// The ID of the transit gateway multicast domain.
    transit_gateway_multicast_domain_id: ?[]const u8,
};
