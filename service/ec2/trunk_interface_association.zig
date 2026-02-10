const InterfaceProtocolType = @import("interface_protocol_type.zig").InterfaceProtocolType;
const Tag = @import("tag.zig").Tag;

/// Information about an association between a branch network interface with a
/// trunk network interface.
pub const TrunkInterfaceAssociation = struct {
    /// The ID of the association.
    association_id: ?[]const u8,

    /// The ID of the branch network interface.
    branch_interface_id: ?[]const u8,

    /// The application key when you use the GRE protocol.
    gre_key: ?i32,

    /// The interface protocol. Valid values are `VLAN` and `GRE`.
    interface_protocol: ?InterfaceProtocolType,

    /// The tags for the trunk interface association.
    tags: ?[]const Tag,

    /// The ID of the trunk network interface.
    trunk_interface_id: ?[]const u8,

    /// The ID of the VLAN when you use the VLAN protocol.
    vlan_id: ?i32,
};
