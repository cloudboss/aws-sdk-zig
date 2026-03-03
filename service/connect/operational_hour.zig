const OverrideTimeSlice = @import("override_time_slice.zig").OverrideTimeSlice;

/// Information about the hours of operations with the effective override
/// applied.
pub const OperationalHour = struct {
    /// The end time that your contact center closes.
    end: ?OverrideTimeSlice = null,

    /// The start time that your contact center opens.
    start: ?OverrideTimeSlice = null,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
    };
};
