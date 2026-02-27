pub const DescribeExecutionRequest = struct {
    /// A unique identifier for the execution of a workflow.
    execution_id: []const u8,

    /// A unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .workflow_id = "WorkflowId",
    };
};
