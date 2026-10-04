const RecoveryPlanStatus = @import("recovery_plan_status.zig").RecoveryPlanStatus;

/// Summary information about a Recovery Plan.
pub const RecoveryPlanSummary = struct {
    /// The timestamp when the Recovery Plan was created.
    created_at: []const u8,

    name: []const u8,

    /// The ARN of the Recovery Plan.
    recovery_plan_arn: []const u8,

    /// The status of the Recovery Plan.
    status: RecoveryPlanStatus,

    /// The timestamp when the Recovery Plan was last updated.
    updated_at: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .name = "name",
        .recovery_plan_arn = "recoveryPlanArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
