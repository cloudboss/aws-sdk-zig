const HoursOfOperationDays = @import("hours_of_operation_days.zig").HoursOfOperationDays;
const HoursOfOperationTimeSlice = @import("hours_of_operation_time_slice.zig").HoursOfOperationTimeSlice;

/// Contains information about the hours of operation.
pub const HoursOfOperationConfig = struct {
    /// The day that the hours of operation applies to.
    day: HoursOfOperationDays,

    /// The end time that your contact center closes.
    end_time: HoursOfOperationTimeSlice,

    /// The start time that your contact center opens.
    start_time: HoursOfOperationTimeSlice,

    pub const json_field_names = .{
        .day = "Day",
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
