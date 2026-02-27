/// Contains the configuration settings of a domain.
pub const DomainConfiguration = struct {
    /// The retention period for workflow executions in this domain.
    workflow_execution_retention_period_in_days: []const u8,

    pub const json_field_names = .{
        .workflow_execution_retention_period_in_days = "workflowExecutionRetentionPeriodInDays",
    };
};
