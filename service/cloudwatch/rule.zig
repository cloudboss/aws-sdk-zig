const Schedule = @import("schedule.zig").Schedule;

/// Defines the schedule configuration for an alarm mute rule.
///
/// The rule contains a schedule that specifies when and how long alarms should
/// be muted. The schedule can be a recurring pattern using cron expressions or
/// a one-time mute window using at expressions.
pub const Rule = struct {
    /// The schedule configuration that defines when the mute rule activates and how
    /// long it remains active.
    schedule: Schedule,

    pub const json_field_names = .{
        .schedule = "Schedule",
    };
};
