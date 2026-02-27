const EstimatedMonthlySavings = @import("estimated_monthly_savings.zig").EstimatedMonthlySavings;
const StepStatus = @import("step_status.zig").StepStatus;
const StepType = @import("step_type.zig").StepType;

/// Contains information about a step in an automation event.
pub const AutomationEventStep = struct {
    /// The timestamp when this automation event step completed execution.
    completed_timestamp: ?i64,

    estimated_monthly_savings: ?EstimatedMonthlySavings,

    /// The ID of the automation event this step belongs to.
    event_id: ?[]const u8,

    /// The unique identifier of the resource being acted upon in this step.
    resource_id: ?[]const u8,

    /// The timestamp when this automation event step started execution.
    start_timestamp: ?i64,

    /// The unique identifier for this step.
    step_id: ?[]const u8,

    /// The current status of the step.
    step_status: ?StepStatus,

    /// The type of step.
    step_type: ?StepType,

    pub const json_field_names = .{
        .completed_timestamp = "completedTimestamp",
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .event_id = "eventId",
        .resource_id = "resourceId",
        .start_timestamp = "startTimestamp",
        .step_id = "stepId",
        .step_status = "stepStatus",
        .step_type = "stepType",
    };
};
