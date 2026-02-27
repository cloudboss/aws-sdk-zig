const RetrainingSchedulerStatus = @import("retraining_scheduler_status.zig").RetrainingSchedulerStatus;

/// Provides information about the specified retraining scheduler, including
/// model name,
/// status, start date, frequency, and lookback window.
pub const RetrainingSchedulerSummary = struct {
    /// The number of past days of data used for retraining.
    lookback_window: ?[]const u8,

    /// The ARN of the model that the retraining scheduler is attached to.
    model_arn: ?[]const u8,

    /// The name of the model that the retraining scheduler is attached to.
    model_name: ?[]const u8,

    /// The frequency at which the model retraining is set. This follows the [ISO
    /// 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)
    /// guidelines.
    retraining_frequency: ?[]const u8,

    /// The start date for the retraining scheduler. Lookout for Equipment truncates
    /// the time you provide to the
    /// nearest UTC day.
    retraining_start_date: ?i64,

    /// The status of the retraining scheduler.
    status: ?RetrainingSchedulerStatus,

    pub const json_field_names = .{
        .lookback_window = "LookbackWindow",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .retraining_frequency = "RetrainingFrequency",
        .retraining_start_date = "RetrainingStartDate",
        .status = "Status",
    };
};
