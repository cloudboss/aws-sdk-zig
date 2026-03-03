const InterfaceProtocolType = @import("interface_protocol_type.zig").InterfaceProtocolType;
const Tag = @import("tag.zig").Tag;

/// Information about an association between a branch network interface with a
/// trunk network interface.
pub const TrunkInterfaceAssociation = struct {
    /// The ID of the association.
    association_id: ?[]const u8 = null,

    /// The ID of the branch network interface.
    branch_interface_id: ?[]const u8 = null,

    /// The application key when you use the GRE protocol.
    gre_key: ?i32 = null,

    /// The interface protocol. Valid values are `VLAN` and `GRE`.
    interface_protocol: ?InterfaceProtocolType = null,

    /// The tags for the trunk interface association.
    tags: ?[]const Tag = null,

    /// The ID of the trunk network interface.
    trunk_interface_id: ?[]const u8 = null,

    /// The ID of the VLAN when you use the VLAN protocol.
    vlan_id: ?i32 = null,
};
