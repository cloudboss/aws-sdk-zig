/// Contains information about an IAM group entity.
///
/// This data type is used as a response element in the following operations:
///
/// *
///   [CreateGroup](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateGroup.html)
///
/// *
///   [GetGroup](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetGroup.html)
///
/// *
///   [ListGroups](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListGroups.html)
pub const Group = struct {
    /// The Amazon Resource Name (ARN) specifying the group. For more information
    /// about ARNs
    /// and how to use them in policies, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    arn: []const u8,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the group was created.
    create_date: i64,

    /// The stable and unique string identifying the group. For more information
    /// about IDs, see
    /// [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    group_id: []const u8,

    /// The friendly name that identifies the group.
    group_name: []const u8,

    /// The path to the group. For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    path: []const u8,
};
