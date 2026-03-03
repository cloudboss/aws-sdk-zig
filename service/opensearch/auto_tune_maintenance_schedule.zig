const Duration = @import("duration.zig").Duration;

/// This object is deprecated. Use the domain's [off-peak
/// window](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/off-peak.html) to schedule Auto-Tune optimizations. For migration instructions,
/// see [Migrating from Auto-Tune maintenance
/// windows](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/off-peak.html#off-peak-migrate).
///
/// The Auto-Tune maintenance schedule. For more information, see [Auto-Tune for
/// Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
pub const AutoTuneMaintenanceSchedule = struct {
    /// A cron expression for a recurring maintenance schedule during which
    /// Auto-Tune can
    /// deploy changes.
    cron_expression_for_recurrence: ?[]const u8 = null,

    /// The duration of the maintenance schedule. For example, `"Duration":
    /// {"Value": 2,
    /// "Unit": "HOURS"}`.
    duration: ?Duration = null,

    /// The Epoch timestamp at which the Auto-Tune maintenance schedule starts.
    start_at: ?i64 = null,

    pub const json_field_names = .{
        .cron_expression_for_recurrence = "CronExpressionForRecurrence",
        .duration = "Duration",
        .start_at = "StartAt",
    };
};
