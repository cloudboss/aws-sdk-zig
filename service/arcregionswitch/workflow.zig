const Step = @import("step.zig").Step;
const WorkflowTargetAction = @import("workflow_target_action.zig").WorkflowTargetAction;

/// Represents a workflow in a Region switch plan. A workflow defines a sequence
/// of steps to execute during a Region switch.
pub const Workflow = struct {
    /// The steps that make up the workflow.
    steps: ?[]const Step,

    /// The description of the workflow.
    workflow_description: ?[]const u8,

    /// The action that the workflow performs. Valid values include `activate` and
    /// `deactivate`.
    workflow_target_action: WorkflowTargetAction,

    /// The Amazon Web Services Region that the workflow targets.
    workflow_target_region: ?[]const u8,

    pub const json_field_names = .{
        .steps = "steps",
        .workflow_description = "workflowDescription",
        .workflow_target_action = "workflowTargetAction",
        .workflow_target_region = "workflowTargetRegion",
    };
};
