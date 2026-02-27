/// The start time or end time for an hours of operation.
pub const HoursOfOperationTimeSlice = struct {
    /// The hours.
    hours: i32,

    /// The minutes.
    minutes: i32,

    pub const json_field_names = .{
        .hours = "Hours",
        .minutes = "Minutes",
    };
};
