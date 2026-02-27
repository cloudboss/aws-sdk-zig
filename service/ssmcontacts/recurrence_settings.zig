const aws = @import("aws");

const HandOffTime = @import("hand_off_time.zig").HandOffTime;
const MonthlySetting = @import("monthly_setting.zig").MonthlySetting;
const CoverageTime = @import("coverage_time.zig").CoverageTime;
const WeeklySetting = @import("weekly_setting.zig").WeeklySetting;

/// Information about when an on-call rotation is in effect and how long the
/// rotation period
/// lasts.
pub const RecurrenceSettings = struct {
    /// Information about on-call rotations that recur daily.
    daily_settings: ?[]const HandOffTime,

    /// Information about on-call rotations that recur monthly.
    monthly_settings: ?[]const MonthlySetting,

    /// The number of contacts, or shift team members designated to be on call
    /// concurrently
    /// during a shift. For example, in an on-call schedule that contains ten
    /// contacts, a value of
    /// `2` designates that two of them are on call at any given time.
    number_of_on_calls: i32,

    /// The number of days, weeks, or months a single rotation lasts.
    recurrence_multiplier: i32,

    /// Information about the days of the week that the on-call rotation coverage
    /// includes.
    shift_coverages: ?[]const aws.map.MapEntry([]const CoverageTime),

    /// Information about on-call rotations that recur weekly.
    weekly_settings: ?[]const WeeklySetting,

    pub const json_field_names = .{
        .daily_settings = "DailySettings",
        .monthly_settings = "MonthlySettings",
        .number_of_on_calls = "NumberOfOnCalls",
        .recurrence_multiplier = "RecurrenceMultiplier",
        .shift_coverages = "ShiftCoverages",
        .weekly_settings = "WeeklySettings",
    };
};
