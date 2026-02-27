const OverrideDays = @import("override_days.zig").OverrideDays;
const OverrideTimeSlice = @import("override_time_slice.zig").OverrideTimeSlice;

/// Information about the hours of operation override config: day, start time,
/// and end time.
pub const HoursOfOperationOverrideConfig = struct {
    /// The day that the hours of operation override applies to.
    day: ?OverrideDays,

    /// The end time that your contact center closes if overrides are applied.
    end_time: ?OverrideTimeSlice,

    /// The start time when your contact center opens if overrides are applied.
    start_time: ?OverrideTimeSlice,

    pub const json_field_names = .{
        .day = "Day",
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
