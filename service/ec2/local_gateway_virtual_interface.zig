const LocalGatewayVirtualInterfaceConfigurationState = @import("local_gateway_virtual_interface_configuration_state.zig").LocalGatewayVirtualInterfaceConfigurationState;
const Tag = @import("tag.zig").Tag;

/// Describes a local gateway virtual interface.
pub const LocalGatewayVirtualInterface = struct {
    /// The current state of the local gateway virtual interface.
    configuration_state: ?LocalGatewayVirtualInterfaceConfigurationState = null,

    /// The local address.
    local_address: ?[]const u8 = null,

    /// The Border Gateway Protocol (BGP) Autonomous System Number (ASN) of the
    /// local gateway.
    local_bgp_asn: ?i32 = null,

    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the local gateway virtual interface.
    local_gateway_virtual_interface_arn: ?[]const u8 = null,

    /// The ID of the local gateway virtual interface group.
    local_gateway_virtual_interface_group_id: ?[]const u8 = null,

    /// The ID of the virtual interface.
    local_gateway_virtual_interface_id: ?[]const u8 = null,

    /// The Outpost LAG ID.
    outpost_lag_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the local gateway
    /// virtual interface.
    owner_id: ?[]const u8 = null,

    /// The peer address.
    peer_address: ?[]const u8 = null,

    /// The peer BGP ASN.
    peer_bgp_asn: ?i32 = null,

    /// The extended 32-bit ASN of the BGP peer for use with larger ASN values.
    peer_bgp_asn_extended: ?i64 = null,

    /// The tags assigned to the virtual interface.
    tags: ?[]const Tag = null,

    /// The ID of the VLAN.
    vlan: ?i32 = null,
};
