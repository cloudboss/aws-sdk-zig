/// The policy usage type that indicates whether the policy is used as a
/// permissions policy
/// or as the permissions boundary for an entity.
///
/// For more information about permissions boundaries, see [Permissions
/// boundaries for IAM
/// identities
/// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
pub const PolicyUsageType = enum {
    permissions_policy,
    permissions_boundary,
};
