const JobScheduleDayOfTheWeek = @import("job_schedule_day_of_the_week.zig").JobScheduleDayOfTheWeek;

/// The day and time when do you want to start the Identity Resolution Job every
/// week.
pub const JobSchedule = struct {
    /// The day when the Identity Resolution Job should run every week.
    day_of_the_week: JobScheduleDayOfTheWeek,

    /// The time when the Identity Resolution Job should run every week.
    time: []const u8,

    pub const json_field_names = .{
        .day_of_the_week = "DayOfTheWeek",
        .time = "Time",
    };
};
