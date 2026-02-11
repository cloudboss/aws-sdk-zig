/// Configuration settings for [durable
/// functions](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html), including execution timeout and retention period for execution history.
pub const DurableConfig = struct {
    /// The maximum time (in seconds) that a durable execution can run before timing
    /// out. This timeout applies to the entire durable execution, not individual
    /// function invocations.
    execution_timeout: ?i32,

    /// The number of days to retain execution history after a durable execution
    /// completes. After this period, execution history is no longer available
    /// through the GetDurableExecutionHistory API.
    retention_period_in_days: ?i32,

    pub const json_field_names = .{
        .execution_timeout = "ExecutionTimeout",
        .retention_period_in_days = "RetentionPeriodInDays",
    };
};
