const LocalGatewayVirtualInterfaceGroupConfigurationState = @import("local_gateway_virtual_interface_group_configuration_state.zig").LocalGatewayVirtualInterfaceGroupConfigurationState;
const Tag = @import("tag.zig").Tag;

/// Describes a local gateway virtual interface group.
pub const LocalGatewayVirtualInterfaceGroup = struct {
    /// The current state of the local gateway virtual interface group.
    configuration_state: ?LocalGatewayVirtualInterfaceGroupConfigurationState = null,

    /// The Autonomous System Number(ASN) for the local Border Gateway Protocol
    /// (BGP).
    local_bgp_asn: ?i32 = null,

    /// The extended 32-bit ASN for the local BGP configuration.
    local_bgp_asn_extended: ?i64 = null,

    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the local gateway virtual interface
    /// group.
    local_gateway_virtual_interface_group_arn: ?[]const u8 = null,

    /// The ID of the virtual interface group.
    local_gateway_virtual_interface_group_id: ?[]const u8 = null,

    /// The IDs of the virtual interfaces.
    local_gateway_virtual_interface_ids: ?[]const []const u8 = null,

    /// The ID of the Amazon Web Services account that owns the local gateway
    /// virtual interface group.
    owner_id: ?[]const u8 = null,

    /// The tags assigned to the virtual interface group.
    tags: ?[]const Tag = null,
};
