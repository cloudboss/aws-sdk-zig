const DelegationStatus = @import("delegation_status.zig").DelegationStatus;

/// The metadata that's associated with the delegation.
pub const DelegationMetadata = struct {
    /// The unique identifier for the assessment.
    assessment_id: ?[]const u8,

    /// The name of the associated assessment.
    assessment_name: ?[]const u8,

    /// Specifies the name of the control set that was delegated for review.
    control_set_name: ?[]const u8,

    /// Specifies when the delegation was created.
    creation_time: ?i64,

    /// The unique identifier for the delegation.
    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role.
    role_arn: ?[]const u8,

    /// The current status of the delegation.
    status: ?DelegationStatus,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .assessment_name = "assessmentName",
        .control_set_name = "controlSetName",
        .creation_time = "creationTime",
        .id = "id",
        .role_arn = "roleArn",
        .status = "status",
    };
};
