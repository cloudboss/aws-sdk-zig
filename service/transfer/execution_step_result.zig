const ExecutionError = @import("execution_error.zig").ExecutionError;
const WorkflowStepType = @import("workflow_step_type.zig").WorkflowStepType;

/// Specifies the following details for the step: error (if any), outputs (if
/// any), and the step type.
pub const ExecutionStepResult = struct {
    /// Specifies the details for an error, if it occurred during execution of the
    /// specified workflow step.
    @"error": ?ExecutionError = null,

    /// The values for the key/value pair applied as a tag to the file. Only
    /// applicable if the step type is `TAG`.
    outputs: ?[]const u8 = null,

    /// One of the available step types.
    ///
    /// * ** `COPY` ** - Copy the file to another location.
    /// * ** `CUSTOM` ** - Perform a custom step with an Lambda function target.
    /// * ** `DECRYPT` ** - Decrypt a file that was encrypted before it was
    ///   uploaded.
    /// * ** `DELETE` ** - Delete the file.
    /// * ** `TAG` ** - Add a tag to the file.
    step_type: ?WorkflowStepType = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .outputs = "Outputs",
        .step_type = "StepType",
    };
};
