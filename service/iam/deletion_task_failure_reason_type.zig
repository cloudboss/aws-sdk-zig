const RoleUsageType = @import("role_usage_type.zig").RoleUsageType;

/// The reason that the service-linked role deletion failed.
///
/// This data type is used as a response element in the
/// [GetServiceLinkedRoleDeletionStatus](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLinkedRoleDeletionStatus.html) operation.
pub const DeletionTaskFailureReasonType = struct {
    /// A short description of the reason that the service-linked role deletion
    /// failed.
    reason: ?[]const u8 = null,

    /// A list of objects that contains details about the service-linked role
    /// deletion failure,
    /// if that information is returned by the service. If the service-linked role
    /// has active
    /// sessions or if any resources that were used by the role have not been
    /// deleted from the
    /// linked service, the role can't be deleted. This parameter includes a list of
    /// the resources
    /// that are associated with the role and the Region in which the resources are
    /// being
    /// used.
    role_usage_list: ?[]const RoleUsageType = null,
};
