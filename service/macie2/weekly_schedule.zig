const DayOfWeek = @import("day_of_week.zig").DayOfWeek;

/// Specifies a weekly recurrence pattern for running a classification job.
pub const WeeklySchedule = struct {
    /// The day of the week when Amazon Macie runs the job.
    day_of_week: ?DayOfWeek = null,

    pub const json_field_names = .{
        .day_of_week = "dayOfWeek",
    };
};
