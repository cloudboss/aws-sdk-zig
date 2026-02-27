const AwsEc2NetworkAclAssociation = @import("aws_ec_2_network_acl_association.zig").AwsEc2NetworkAclAssociation;
const AwsEc2NetworkAclEntry = @import("aws_ec_2_network_acl_entry.zig").AwsEc2NetworkAclEntry;

/// Contains details about an Amazon EC2 network access control list (ACL).
pub const AwsEc2NetworkAclDetails = struct {
    /// Associations between the network ACL and subnets.
    associations: ?[]const AwsEc2NetworkAclAssociation,

    /// The set of rules in the network ACL.
    entries: ?[]const AwsEc2NetworkAclEntry,

    /// Whether this is the default network ACL for the VPC.
    is_default: ?bool,

    /// The identifier of the network ACL.
    network_acl_id: ?[]const u8,

    /// The identifier of the Amazon Web Services account that owns the network ACL.
    owner_id: ?[]const u8,

    /// The identifier of the VPC for the network ACL.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .associations = "Associations",
        .entries = "Entries",
        .is_default = "IsDefault",
        .network_acl_id = "NetworkAclId",
        .owner_id = "OwnerId",
        .vpc_id = "VpcId",
    };
};
