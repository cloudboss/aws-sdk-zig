const RoleType = @import("role_type.zig").RoleType;

/// A collection of attributes that's used to create a delegation for an
/// assessment in
/// Audit Manager.
pub const CreateDelegationRequest = struct {
    /// A comment that's related to the delegation request.
    comment: ?[]const u8,

    /// The unique identifier for the control set.
    control_set_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role.
    role_arn: ?[]const u8,

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
    role_type: ?RoleType,

    pub const json_field_names = .{
        .comment = "comment",
        .control_set_id = "controlSetId",
        .role_arn = "roleArn",
        .role_type = "roleType",
    };
};
