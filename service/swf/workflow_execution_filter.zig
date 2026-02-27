/// Used to filter the workflow executions in visibility APIs by their
/// `workflowId`.
pub const WorkflowExecutionFilter = struct {
    /// The workflowId to pass of match the criteria of this filter.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .workflow_id = "workflowId",
    };
};
