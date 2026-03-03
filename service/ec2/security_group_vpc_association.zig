const SecurityGroupVpcAssociationState = @import("security_group_vpc_association_state.zig").SecurityGroupVpcAssociationState;

/// A security group association with a VPC that you made with
/// [AssociateSecurityGroupVpc](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AssociateSecurityGroupVpc.html).
pub const SecurityGroupVpcAssociation = struct {
    /// The association's security group ID.
    group_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the owner of the security group.
    group_owner_id: ?[]const u8 = null,

    /// The association's state.
    state: ?SecurityGroupVpcAssociationState = null,

    /// The association's state reason.
    state_reason: ?[]const u8 = null,

    /// The association's VPC ID.
    vpc_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the owner of the VPC.
    vpc_owner_id: ?[]const u8 = null,
};
