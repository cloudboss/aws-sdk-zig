const DescribedExecution = @import("described_execution.zig").DescribedExecution;

pub const DescribeExecutionResponse = struct {
    /// The structure that contains the details of the workflow' execution.
    execution: DescribedExecution,

    /// A unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .execution = "Execution",
        .workflow_id = "WorkflowId",
    };
};
