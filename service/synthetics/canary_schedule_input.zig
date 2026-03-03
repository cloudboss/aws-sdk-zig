const RetryConfigInput = @import("retry_config_input.zig").RetryConfigInput;

/// This structure specifies how often a canary is to make runs and the date and
/// time
/// when it should stop making runs.
pub const CanaryScheduleInput = struct {
    /// How long, in seconds, for the canary to continue making regular runs
    /// according to
    /// the schedule in the `Expression` value. If you specify 0, the canary
    /// continues
    /// making runs until you stop it. If you omit this field, the default of 0 is
    /// used.
    duration_in_seconds: ?i64 = null,

    /// A `rate` expression or a `cron` expression that defines how often the canary
    /// is to run.
    ///
    /// For a rate expression, The syntax is
    /// `rate(*number unit*)`. *unit*
    /// can be `minute`, `minutes`, or `hour`.
    ///
    /// For example, `rate(1 minute)` runs the canary once a minute, `rate(10
    /// minutes)` runs it once every
    /// 10 minutes, and `rate(1 hour)` runs it once every hour. You can
    /// specify a frequency between `rate(1 minute)` and `rate(1 hour)`.
    ///
    /// Specifying `rate(0 minute)` or `rate(0 hour)` is a special value
    /// that causes the
    /// canary to run only once when it is started.
    ///
    /// Use `cron(*expression*)` to specify a cron
    /// expression. You can't schedule a canary to wait for more than a year before
    /// running. For information about the syntax for cron expressions, see
    /// [
    /// Scheduling canary runs using
    /// cron](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_cron.html).
    expression: []const u8,

    /// A structure that contains the retry configuration for a canary
    retry_config: ?RetryConfigInput = null,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
        .expression = "Expression",
        .retry_config = "RetryConfig",
    };
};
