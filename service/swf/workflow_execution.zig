/// Represents a workflow execution.
pub const WorkflowExecution = struct {
    /// A system-generated unique identifier for the workflow execution.
    run_id: []const u8,

    /// The user defined identifier associated with the workflow execution.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .run_id = "runId",
        .workflow_id = "workflowId",
    };
};
