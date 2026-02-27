const WorkflowTargetAction = @import("workflow_target_action.zig").WorkflowTargetAction;
const TriggerCondition = @import("trigger_condition.zig").TriggerCondition;

/// Defines a condition that can automatically trigger the execution of a Region
/// switch plan.
pub const Trigger = struct {
    /// The action to perform when the trigger fires. Valid values include
    /// `activate` and `deactivate`.
    action: WorkflowTargetAction,

    /// The conditions that must be met for the trigger to fire.
    conditions: []const TriggerCondition,

    /// The description for a trigger.
    description: ?[]const u8,

    /// The minimum time, in minutes, that must elapse between automatic executions
    /// of the plan.
    min_delay_minutes_between_executions: i32,

    /// The Amazon Web Services Region for a trigger.
    target_region: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .conditions = "conditions",
        .description = "description",
        .min_delay_minutes_between_executions = "minDelayMinutesBetweenExecutions",
        .target_region = "targetRegion",
    };
};
