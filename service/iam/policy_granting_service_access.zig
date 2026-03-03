const policyOwnerEntityType = @import("policy_owner_entity_type.zig").policyOwnerEntityType;
const policyType = @import("policy_type.zig").policyType;

/// Contains details about the permissions policies that are attached to the
/// specified
/// identity (user, group, or role).
///
/// This data type is an element of the
/// [ListPoliciesGrantingServiceAccessEntry](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListPoliciesGrantingServiceAccessEntry.html) object.
pub const PolicyGrantingServiceAccess = struct {
    /// The name of the entity (user or role) to which the inline policy is
    /// attached.
    ///
    /// This field is null for managed policies. For more information about these
    /// policy types,
    /// see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html) in the
    /// *IAM User Guide*.
    entity_name: ?[]const u8 = null,

    /// The type of entity (user or role) that used the policy to access the service
    /// to which
    /// the inline policy is attached.
    ///
    /// This field is null for managed policies. For more information about these
    /// policy types,
    /// see [Managed policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html) in the
    /// *IAM User Guide*.
    entity_type: ?policyOwnerEntityType = null,

    policy_arn: ?[]const u8 = null,

    /// The policy name.
    policy_name: []const u8,

    /// The policy type. For more information about these policy types, see [Managed
    /// policies and inline
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html) in the
    /// *IAM User Guide*.
    policy_type: policyType,
};
