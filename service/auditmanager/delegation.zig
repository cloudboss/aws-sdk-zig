const RoleType = @import("role_type.zig").RoleType;
const DelegationStatus = @import("delegation_status.zig").DelegationStatus;

/// The assignment of a control set to a delegate for review.
pub const Delegation = struct {
    /// The identifier for the assessment that's associated with the delegation.
    assessment_id: ?[]const u8,

    /// The name of the assessment that's associated with the delegation.
    assessment_name: ?[]const u8,

    /// The comment that's related to the delegation.
    comment: ?[]const u8,

    /// The identifier for the control set that's associated with the delegation.
    control_set_id: ?[]const u8,

    /// The user or role that created the delegation.
    created_by: ?[]const u8,

    /// Specifies when the delegation was created.
    creation_time: ?i64,

    /// The unique identifier for the delegation.
    id: ?[]const u8,

    /// Specifies when the delegation was last updated.
    last_updated: ?i64,

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

    /// The status of the delegation.
    status: ?DelegationStatus,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .assessment_name = "assessmentName",
        .comment = "comment",
        .control_set_id = "controlSetId",
        .created_by = "createdBy",
        .creation_time = "creationTime",
        .id = "id",
        .last_updated = "lastUpdated",
        .role_arn = "roleArn",
        .role_type = "roleType",
        .status = "status",
    };
};
