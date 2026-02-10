const AttachedPolicy = @import("attached_policy.zig").AttachedPolicy;
const AttachedPermissionsBoundary = @import("attached_permissions_boundary.zig").AttachedPermissionsBoundary;
const Tag = @import("tag.zig").Tag;
const PolicyDetail = @import("policy_detail.zig").PolicyDetail;

/// Contains information about an IAM user, including all the user's policies
/// and all the
/// IAM groups the user is in.
///
/// This data type is used as a response element in the
/// [GetAccountAuthorizationDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountAuthorizationDetails.html) operation.
pub const UserDetail = struct {
    arn: ?[]const u8,

    /// A list of the managed policies attached to the user.
    attached_managed_policies: ?[]const AttachedPolicy,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the user was created.
    create_date: ?i64,

    /// A list of IAM groups that the user is in.
    group_list: ?[]const []const u8,

    /// The path to the user. For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    path: ?[]const u8,

    /// The ARN of the policy used to set the permissions boundary for the user.
    ///
    /// For more information about permissions boundaries, see [Permissions
    /// boundaries for IAM
    /// identities
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
    permissions_boundary: ?AttachedPermissionsBoundary,

    /// A list of tags that are associated with the user. For more information about
    /// tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag,

    /// The stable and unique string identifying the user. For more information
    /// about IDs, see
    /// [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    user_id: ?[]const u8,

    /// The friendly name identifying the user.
    user_name: ?[]const u8,

    /// A list of the inline policies embedded in the user.
    user_policy_list: ?[]const PolicyDetail,
};
