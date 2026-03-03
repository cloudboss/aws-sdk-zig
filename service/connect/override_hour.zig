const OverrideTimeSlice = @import("override_time_slice.zig").OverrideTimeSlice;
const OperationalStatus = @import("operational_status.zig").OperationalStatus;

/// Information about hours of operation override
pub const OverrideHour = struct {
    end: ?OverrideTimeSlice = null,

    /// Indicates whether the status is open or closed during the override period.
    /// This status determines how the override modifies the base hours of operation
    /// schedule.
    operational_status: ?OperationalStatus = null,

    /// Unique identifier name for the override.
    override_name: ?[]const u8 = null,

    start: ?OverrideTimeSlice = null,

    pub const json_field_names = .{
        .end = "End",
        .operational_status = "OperationalStatus",
        .override_name = "OverrideName",
        .start = "Start",
    };
};
