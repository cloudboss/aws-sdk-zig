const ListedExecution = @import("listed_execution.zig").ListedExecution;

pub const ListExecutionsResponse = struct {
    /// Returns the details for each execution, in a `ListedExecution` array.
    executions: []const ListedExecution,

    /// `ListExecutions` returns the `NextToken` parameter in the output. You can
    /// then pass the `NextToken` parameter in a subsequent command to continue
    /// listing additional executions.
    next_token: ?[]const u8,

    /// A unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .executions = "Executions",
        .next_token = "NextToken",
        .workflow_id = "WorkflowId",
    };
};
