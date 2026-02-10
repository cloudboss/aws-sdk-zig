/// Describes an association between a network ACL and a subnet.
pub const NetworkAclAssociation = struct {
    /// The ID of the association between a network ACL and a subnet.
    network_acl_association_id: ?[]const u8,

    /// The ID of the network ACL.
    network_acl_id: ?[]const u8,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,
};
