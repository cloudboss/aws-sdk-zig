const AutomationExecutionInputs = @import("automation_execution_inputs.zig").AutomationExecutionInputs;

/// Information about the inputs for an execution preview.
pub const ExecutionInputs = union(enum) {
    /// Information about the optional inputs that can be specified for an
    /// automation execution
    /// preview.
    automation: ?AutomationExecutionInputs,

    pub const json_field_names = .{
        .automation = "Automation",
    };
};
