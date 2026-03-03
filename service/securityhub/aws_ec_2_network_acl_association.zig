/// An association between the network ACL and a subnet.
pub const AwsEc2NetworkAclAssociation = struct {
    /// The identifier of the association between the network ACL and the subnet.
    network_acl_association_id: ?[]const u8 = null,

    /// The identifier of the network ACL.
    network_acl_id: ?[]const u8 = null,

    /// The identifier of the subnet that is associated with the network ACL.
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .network_acl_association_id = "NetworkAclAssociationId",
        .network_acl_id = "NetworkAclId",
        .subnet_id = "SubnetId",
    };
};
