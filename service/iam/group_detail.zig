const AttachedPolicy = @import("attached_policy.zig").AttachedPolicy;
const PolicyDetail = @import("policy_detail.zig").PolicyDetail;

/// Contains information about an IAM group, including all of the group's
/// policies.
///
/// This data type is used as a response element in the
/// [GetAccountAuthorizationDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountAuthorizationDetails.html) operation.
pub const GroupDetail = struct {
    arn: ?[]const u8 = null,

    /// A list of the managed policies attached to the group.
    attached_managed_policies: ?[]const AttachedPolicy = null,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the group was created.
    create_date: ?i64 = null,

    /// The stable and unique string identifying the group. For more information
    /// about IDs, see
    /// [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    group_id: ?[]const u8 = null,

    /// The friendly name that identifies the group.
    group_name: ?[]const u8 = null,

    /// A list of the inline policies embedded in the group.
    group_policy_list: ?[]const PolicyDetail = null,

    /// The path to the group. For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    path: ?[]const u8 = null,
};
