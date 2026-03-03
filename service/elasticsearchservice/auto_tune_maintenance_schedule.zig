const Duration = @import("duration.zig").Duration;

/// Specifies Auto-Tune maitenance schedule. See the [Developer
/// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
pub const AutoTuneMaintenanceSchedule = struct {
    /// Specifies cron expression for a recurring maintenance schedule. See the
    /// [Developer
    /// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
    cron_expression_for_recurrence: ?[]const u8 = null,

    /// Specifies maintenance schedule duration: duration value and duration unit.
    /// See the [Developer
    /// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
    duration: ?Duration = null,

    /// Specifies timestamp at which Auto-Tune maintenance schedule start.
    start_at: ?i64 = null,

    pub const json_field_names = .{
        .cron_expression_for_recurrence = "CronExpressionForRecurrence",
        .duration = "Duration",
        .start_at = "StartAt",
    };
};
