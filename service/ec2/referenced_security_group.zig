/// Describes the security group that is referenced in the security group rule.
pub const ReferencedSecurityGroup = struct {
    /// The ID of the security group.
    group_id: ?[]const u8 = null,

    /// The status of a VPC peering connection, if applicable.
    peering_status: ?[]const u8 = null,

    /// The Amazon Web Services account ID.
    user_id: ?[]const u8 = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    /// The ID of the VPC peering connection (if applicable).
    vpc_peering_connection_id: ?[]const u8 = null,
};
