const RecurrencePattern = @import("recurrence_pattern.zig").RecurrencePattern;

/// Defines the recurrence configuration for overrides. This configuration uses
/// a recurrence pattern to specify when and how frequently an event should
/// repeat.
pub const RecurrenceConfig = struct {
    /// The recurrence pattern that defines how the event repeats. Example:
    /// Frequency, Interval, ByMonth, ByMonthDay, ByWeekdayOccurrence
    recurrence_pattern: RecurrencePattern,

    pub const json_field_names = .{
        .recurrence_pattern = "RecurrencePattern",
    };
};
