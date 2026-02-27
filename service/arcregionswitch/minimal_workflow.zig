const ExecutionAction = @import("execution_action.zig").ExecutionAction;

/// A simplified representation of a workflow in a Region switch plan.
pub const MinimalWorkflow = struct {
    /// The action for a minimal workflow, which can be Activate or Deactivate.
    action: ?ExecutionAction,

    /// The name for a minimal workflow
    name: ?[]const u8,

    pub const json_field_names = .{
        .action = "action",
        .name = "name",
    };
};
