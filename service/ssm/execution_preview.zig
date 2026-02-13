const AutomationExecutionPreview = @import("automation_execution_preview.zig").AutomationExecutionPreview;

/// Information about the changes that would be made if an execution were run.
pub const ExecutionPreview = union(enum) {
    /// Information about the changes that would be made if an Automation workflow
    /// were run.
    automation: ?AutomationExecutionPreview,

    pub const json_field_names = .{
        .automation = "Automation",
    };
};
