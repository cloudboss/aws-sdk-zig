const ScheduledAutoTuneActionType = @import("scheduled_auto_tune_action_type.zig").ScheduledAutoTuneActionType;
const ScheduledAutoTuneSeverityType = @import("scheduled_auto_tune_severity_type.zig").ScheduledAutoTuneSeverityType;

/// Specifies details of the scheduled Auto-Tune action. See the [Developer
/// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
pub const ScheduledAutoTuneDetails = struct {
    /// Specifies Auto-Tune action description.
    action: ?[]const u8,

    /// Specifies Auto-Tune action type. Valid values are JVM_HEAP_SIZE_TUNING and
    /// JVM_YOUNG_GEN_TUNING.
    action_type: ?ScheduledAutoTuneActionType,

    /// Specifies timestamp for the Auto-Tune action scheduled for the domain.
    date: ?i64,

    /// Specifies Auto-Tune action severity. Valid values are LOW, MEDIUM and HIGH.
    severity: ?ScheduledAutoTuneSeverityType,

    pub const json_field_names = .{
        .action = "Action",
        .action_type = "ActionType",
        .date = "Date",
        .severity = "Severity",
    };
};
