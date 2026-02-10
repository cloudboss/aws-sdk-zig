/// Describes the registered transit gateway multicast group members.
pub const TransitGatewayMulticastRegisteredGroupMembers = struct {
    /// The IP address assigned to the transit gateway multicast group.
    group_ip_address: ?[]const u8,

    /// The ID of the registered network interfaces.
    registered_network_interface_ids: ?[]const []const u8,

    /// The ID of the transit gateway multicast domain.
    transit_gateway_multicast_domain_id: ?[]const u8,
};
