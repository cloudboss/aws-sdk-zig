const RecurrenceRule = @import("recurrence_rule.zig").RecurrenceRule;
const Window = @import("window.zig").Window;

/// The core SLO time window exclusion object that includes Window, StartTime,
/// RecurrenceRule, and Reason.
pub const ExclusionWindow = struct {
    /// A description explaining why this time period should be excluded from SLO
    /// calculations.
    reason: ?[]const u8 = null,

    /// The recurrence rule for the SLO time window exclusion. Supports both cron
    /// and rate expressions.
    recurrence_rule: ?RecurrenceRule = null,

    /// The start of the SLO time window exclusion. Defaults to current time if not
    /// specified.
    start_time: ?i64 = null,

    /// The SLO time window exclusion .
    window: Window,

    pub const json_field_names = .{
        .reason = "Reason",
        .recurrence_rule = "RecurrenceRule",
        .start_time = "StartTime",
        .window = "Window",
    };
};
