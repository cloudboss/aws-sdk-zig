const LinkAssociationState = @import("link_association_state.zig").LinkAssociationState;

/// Describes the association between a device and a link.
pub const LinkAssociation = struct {
    /// The device ID for the link association.
    device_id: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: ?[]const u8 = null,

    /// The state of the association.
    link_association_state: ?LinkAssociationState = null,

    /// The ID of the link.
    link_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .link_association_state = "LinkAssociationState",
        .link_id = "LinkId",
    };
};
