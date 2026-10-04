/// Configuration settings for [durable
/// functions](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html), including execution timeout, retention period for execution history, and an optional ARN of the Key Management Service (KMS) customer managed key that is used to encrypt your durable execution's payload data, including input, output, and error payloads.
pub const DurableConfig = struct {
    /// The maximum time (in seconds) that a durable execution can run before timing
    /// out. This timeout applies to the entire durable execution, not individual
    /// function invocations.
    execution_timeout: ?i32 = null,

    /// The ARN of the Key Management Service (KMS) customer managed key that is
    /// used to encrypt your durable execution's payload data, including input,
    /// output, and error payloads.
    kms_key_arn: ?[]const u8 = null,

    /// The number of days to retain execution history after a durable execution
    /// completes. After this period, execution history is no longer available
    /// through the GetDurableExecutionHistory API.
    retention_period_in_days: ?i32 = null,

    pub const json_field_names = .{
        .execution_timeout = "ExecutionTimeout",
        .kms_key_arn = "KMSKeyArn",
        .retention_period_in_days = "RetentionPeriodInDays",
    };
};
