/// Contains information about a group that a managed policy is attached to.
///
/// This data type is used as a response element in the
/// [ListEntitiesForPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListEntitiesForPolicy.html) operation.
///
/// For more information about managed policies, refer to [Managed policies and
/// inline
/// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/policies-managed-vs-inline.html) in the *IAM User Guide*.
pub const PolicyGroup = struct {
    /// The stable and unique string identifying the group. For more information
    /// about IDs, see
    /// [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the *IAM User Guide*.
    group_id: ?[]const u8,

    /// The name (friendly name, not ARN) identifying the group.
    group_name: ?[]const u8,
};
