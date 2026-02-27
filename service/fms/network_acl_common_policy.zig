const NetworkAclEntrySet = @import("network_acl_entry_set.zig").NetworkAclEntrySet;

/// Defines a Firewall Manager network ACL policy. This is used in the
/// `PolicyOption` of a `SecurityServicePolicyData` for a `Policy`, when
/// the `SecurityServicePolicyData` type is set to `NETWORK_ACL_COMMON`.
///
/// For information about network ACLs, see
/// [Control traffic to subnets using network
/// ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)
/// in the *Amazon Virtual Private Cloud User Guide*.
pub const NetworkAclCommonPolicy = struct {
    /// The definition of the first and last rules for the network ACL policy.
    network_acl_entry_set: NetworkAclEntrySet,

    pub const json_field_names = .{
        .network_acl_entry_set = "NetworkAclEntrySet",
    };
};
