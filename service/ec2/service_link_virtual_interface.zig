const ServiceLinkVirtualInterfaceConfigurationState = @import("service_link_virtual_interface_configuration_state.zig").ServiceLinkVirtualInterfaceConfigurationState;
const Tag = @import("tag.zig").Tag;

/// Describes the service link virtual interfaces that establish connectivity
/// between Amazon Web Services Outpost and on-premises networks.
pub const ServiceLinkVirtualInterface = struct {
    /// The current state of the service link virtual interface.
    configuration_state: ?ServiceLinkVirtualInterfaceConfigurationState,

    /// The IPv4 address assigned to the local gateway virtual interface on the
    /// Outpost side.
    local_address: ?[]const u8,

    /// The Outpost Amazon Resource Number (ARN) for the service link virtual
    /// interface.
    outpost_arn: ?[]const u8,

    /// The Outpost ID for the service link virtual interface.
    outpost_id: ?[]const u8,

    /// The link aggregation group (LAG) ID for the service link virtual interface.
    outpost_lag_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the service link virtual
    /// interface..
    owner_id: ?[]const u8,

    /// The IPv4 peer address for the service link virtual interface.
    peer_address: ?[]const u8,

    /// The ASN for the Border Gateway Protocol (BGP) associated with the service
    /// link virtual interface.
    peer_bgp_asn: ?i64,

    /// The Amazon Resource Number (ARN) for the service link virtual interface.
    service_link_virtual_interface_arn: ?[]const u8,

    /// The ID of the service link virtual interface.
    service_link_virtual_interface_id: ?[]const u8,

    /// The tags associated with the service link virtual interface.
    tags: ?[]const Tag,

    /// The virtual local area network for the service link virtual interface.
    vlan: ?i32,
};
