const Owner = @import("owner.zig").Owner;
const StepStatus = @import("step_status.zig").StepStatus;
const StepActionType = @import("step_action_type.zig").StepActionType;

/// The summary of the step in a migration workflow.
pub const WorkflowStepSummary = struct {
    /// The description of the step.
    description: ?[]const u8,

    /// The name of the step.
    name: ?[]const u8,

    /// The next step.
    next: ?[]const []const u8,

    /// The number of servers that have been migrated.
    no_of_srv_completed: ?i32,

    /// The number of servers that have failed to migrate.
    no_of_srv_failed: ?i32,

    /// The owner of the step.
    owner: ?Owner,

    /// The previous step.
    previous: ?[]const []const u8,

    /// The location of the script.
    script_location: ?[]const u8,

    /// The status of the step.
    status: ?StepStatus,

    /// The status message of the migration workflow.
    status_message: ?[]const u8,

    /// The action type of the step. You must run and update the status of a manual
    /// step for
    /// the workflow to continue after the completion of the step.
    step_action_type: ?StepActionType,

    /// The ID of the step.
    step_id: ?[]const u8,

    /// The total number of servers that have been migrated.
    total_no_of_srv: ?i32,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .next = "next",
        .no_of_srv_completed = "noOfSrvCompleted",
        .no_of_srv_failed = "noOfSrvFailed",
        .owner = "owner",
        .previous = "previous",
        .script_location = "scriptLocation",
        .status = "status",
        .status_message = "statusMessage",
        .step_action_type = "stepActionType",
        .step_id = "stepId",
        .total_no_of_srv = "totalNoOfSrv",
    };
};
