/// An object that contains details about how a service-linked role is used, if
/// that
/// information is returned by the service.
///
/// This data type is used as a response element in the
/// [GetServiceLinkedRoleDeletionStatus](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLinkedRoleDeletionStatus.html) operation.
pub const RoleUsageType = struct {
    /// The name of the Region where the service-linked role is being used.
    region: ?[]const u8 = null,

    /// The name of the resource that is using the service-linked role.
    resources: ?[]const []const u8 = null,
};
