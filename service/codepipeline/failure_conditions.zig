const Condition = @import("condition.zig").Condition;
const Result = @import("result.zig").Result;
const RetryConfiguration = @import("retry_configuration.zig").RetryConfiguration;

/// The configuration that specifies the result, such as rollback, to occur upon
/// stage
/// failure. For more information about conditions, see [Stage
/// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html)
/// and [How do
/// stage conditions
/// work?](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts-how-it-works-conditions.html).
pub const FailureConditions = struct {
    /// The conditions that are configured as failure conditions. For more
    /// information about
    /// conditions, see [Stage
    /// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html)
    /// and [How do
    /// stage conditions
    /// work?](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts-how-it-works-conditions.html).
    conditions: ?[]const Condition = null,

    /// The specified result for when the failure conditions are met, such as
    /// rolling back the
    /// stage.
    result: ?Result = null,

    /// The retry configuration specifies automatic retry for a failed stage, along
    /// with the
    /// configured retry mode.
    retry_configuration: ?RetryConfiguration = null,

    pub const json_field_names = .{
        .conditions = "conditions",
        .result = "result",
        .retry_configuration = "retryConfiguration",
    };
};
