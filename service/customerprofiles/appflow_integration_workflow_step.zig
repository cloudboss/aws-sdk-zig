const Status = @import("status.zig").Status;

/// Workflow step details for `APPFLOW_INTEGRATION` workflow.
pub const AppflowIntegrationWorkflowStep = struct {
    /// End datetime of records pulled in batch during execution of workflow step
    /// for
    /// `APPFLOW_INTEGRATION` workflow.
    batch_records_end_time: []const u8,

    /// Start datetime of records pulled in batch during execution of workflow step
    /// for
    /// `APPFLOW_INTEGRATION` workflow.
    batch_records_start_time: []const u8,

    /// Creation timestamp of workflow step for `APPFLOW_INTEGRATION`
    /// workflow.
    created_at: i64,

    /// Message indicating execution of workflow step for `APPFLOW_INTEGRATION`
    /// workflow.
    execution_message: []const u8,

    /// Name of the flow created during execution of workflow step.
    /// `APPFLOW_INTEGRATION` workflow type creates an appflow flow during workflow
    /// step execution on the customers behalf.
    flow_name: []const u8,

    /// Last updated timestamp for workflow step for `APPFLOW_INTEGRATION`
    /// workflow.
    last_updated_at: i64,

    /// Total number of records processed during execution of workflow step for
    /// `APPFLOW_INTEGRATION` workflow.
    records_processed: i64 = 0,

    /// Workflow step status for `APPFLOW_INTEGRATION` workflow.
    status: Status,

    pub const json_field_names = .{
        .batch_records_end_time = "BatchRecordsEndTime",
        .batch_records_start_time = "BatchRecordsStartTime",
        .created_at = "CreatedAt",
        .execution_message = "ExecutionMessage",
        .flow_name = "FlowName",
        .last_updated_at = "LastUpdatedAt",
        .records_processed = "RecordsProcessed",
        .status = "Status",
    };
};
