const RetryConfigOutput = @import("retry_config_output.zig").RetryConfigOutput;

/// How long, in seconds, for the canary to continue making regular runs
/// according to the schedule in the
/// `Expression` value.
pub const CanaryScheduleOutput = struct {
    /// How long, in seconds, for the canary to continue making regular runs after
    /// it
    /// was created. The runs are performed according to the schedule in the
    /// `Expression` value.
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
    /// expression. For information about the syntax for cron expressions, see
    /// [
    /// Scheduling canary runs using
    /// cron](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_cron.html).
    expression: ?[]const u8 = null,

    /// A structure that contains the retry configuration for a canary
    retry_config: ?RetryConfigOutput = null,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
        .expression = "Expression",
        .retry_config = "RetryConfig",
    };
};
