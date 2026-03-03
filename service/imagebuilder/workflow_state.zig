const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;

/// A group of fields that describe the current status of workflow.
pub const WorkflowState = struct {
    /// Describes how or why the workflow changed state.
    reason: ?[]const u8 = null,

    /// The current state of the workflow.
    status: ?WorkflowStatus = null,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
