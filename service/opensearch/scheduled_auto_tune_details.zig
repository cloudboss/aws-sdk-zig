const ScheduledAutoTuneActionType = @import("scheduled_auto_tune_action_type.zig").ScheduledAutoTuneActionType;
const ScheduledAutoTuneSeverityType = @import("scheduled_auto_tune_severity_type.zig").ScheduledAutoTuneSeverityType;

/// Specifies details about a scheduled Auto-Tune action. For more information,
/// see [Auto-Tune for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
pub const ScheduledAutoTuneDetails = struct {
    /// A description of the Auto-Tune action.
    action: ?[]const u8 = null,

    /// The type of Auto-Tune action.
    action_type: ?ScheduledAutoTuneActionType = null,

    /// The date and time when the Auto-Tune action is scheduled for the domain.
    date: ?i64 = null,

    /// The severity of the Auto-Tune action. Valid values are `LOW`,
    /// `MEDIUM`, and `HIGH`.
    severity: ?ScheduledAutoTuneSeverityType = null,

    pub const json_field_names = .{
        .action = "Action",
        .action_type = "ActionType",
        .date = "Date",
        .severity = "Severity",
    };
};
