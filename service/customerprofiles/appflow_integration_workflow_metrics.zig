/// Workflow specific execution metrics for `APPFLOW_INTEGRATION`
/// workflow.
pub const AppflowIntegrationWorkflowMetrics = struct {
    /// Number of records processed in `APPFLOW_INTEGRATION` workflow.
    records_processed: i64 = 0,

    /// Total steps completed in `APPFLOW_INTEGRATION` workflow.
    steps_completed: i64 = 0,

    /// Total steps in `APPFLOW_INTEGRATION` workflow.
    total_steps: i64 = 0,

    pub const json_field_names = .{
        .records_processed = "RecordsProcessed",
        .steps_completed = "StepsCompleted",
        .total_steps = "TotalSteps",
    };
};
