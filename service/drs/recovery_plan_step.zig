const RecoveryPlanStepConfiguration = @import("recovery_plan_step_configuration.zig").RecoveryPlanStepConfiguration;

/// A Recovery Plan Step resource.
pub const RecoveryPlanStep = struct {
    configuration: RecoveryPlanStepConfiguration,

    /// The timestamp when the step was created.
    created_at: []const u8,

    /// The ARN of the Recovery Plan step.
    recovery_plan_step_arn: []const u8,

    step_name: []const u8,

    step_order: i32,

    /// The timestamp when the step was last updated.
    updated_at: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .created_at = "createdAt",
        .recovery_plan_step_arn = "recoveryPlanStepArn",
        .step_name = "stepName",
        .step_order = "stepOrder",
        .updated_at = "updatedAt",
    };
};
