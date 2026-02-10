const PolicyVersion = @import("policy_version.zig").PolicyVersion;

/// Contains information about a managed policy, including the policy's ARN,
/// versions, and
/// the number of principal entities (users, groups, and roles) that the policy
/// is attached
/// to.
///
/// This data type is used as a response element in the
/// [GetAccountAuthorizationDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountAuthorizationDetails.html) operation.
///
/// For more information about managed policies, see [Managed policies and
/// inline
/// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
pub const ManagedPolicyDetail = struct {
    arn: ?[]const u8,

    /// The number of principal entities (users, groups, and roles) that the policy
    /// is attached
    /// to.
    attachment_count: ?i32,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the policy was created.
    create_date: ?i64,

    /// The identifier for the version of the policy that is set as the default
    /// (operative)
    /// version.
    ///
    /// For more information about policy versions, see [Versioning for managed
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-versions.html) in the *IAM User Guide*.
    default_version_id: ?[]const u8,

    /// A friendly description of the policy.
    description: ?[]const u8,

    /// Specifies whether the policy can be attached to an IAM user, group, or role.
    is_attachable: ?bool,

    /// The path to the policy.
    ///
    /// For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    path: ?[]const u8,

    /// The number of entities (users and roles) for which the policy is used as the
    /// permissions
    /// boundary.
    ///
    /// For more information about permissions boundaries, see [Permissions
    /// boundaries for IAM
    /// identities
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
    permissions_boundary_usage_count: ?i32,

    /// The stable and unique string identifying the policy.
    ///
    /// For more information about IDs, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    policy_id: ?[]const u8,

    /// The friendly name (not ARN) identifying the policy.
    policy_name: ?[]const u8,

    /// A list containing information about the versions of the policy.
    policy_version_list: ?[]const PolicyVersion,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the policy was last updated.
    ///
    /// When a policy has only one version, this field contains the date and time
    /// when the
    /// policy was created. When a policy has more than one version, this field
    /// contains the date
    /// and time when the most recent policy version was created.
    update_date: ?i64,
};
