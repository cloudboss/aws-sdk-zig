/// Describes the deregistered transit gateway multicast group sources.
pub const TransitGatewayMulticastDeregisteredGroupSources = struct {
    /// The network interface IDs of the non-registered members.
    deregistered_network_interface_ids: ?[]const []const u8 = null,

    /// The IP address assigned to the transit gateway multicast group.
    group_ip_address: ?[]const u8 = null,

    /// The ID of the transit gateway multicast domain.
    transit_gateway_multicast_domain_id: ?[]const u8 = null,
};
