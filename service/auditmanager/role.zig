const RoleType = @import("role_type.zig").RoleType;

/// The wrapper that contains the Audit Manager role information of the current
/// user.
/// This includes the role type and IAM Amazon Resource Name (ARN).
pub const Role = struct {
    /// The Amazon Resource Name (ARN) of the IAM role.
    role_arn: []const u8,

    /// The type of customer persona.
    ///
    /// In `CreateAssessment`, `roleType` can only be
    /// `PROCESS_OWNER`.
    ///
    /// In `UpdateSettings`, `roleType` can only be
    /// `PROCESS_OWNER`.
    ///
    /// In `BatchCreateDelegationByAssessment`, `roleType` can only be
    /// `RESOURCE_OWNER`.
    role_type: RoleType,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .role_type = "roleType",
    };
};
