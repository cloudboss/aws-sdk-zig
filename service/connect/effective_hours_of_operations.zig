const OperationalHour = @import("operational_hour.zig").OperationalHour;

/// Information about the hours of operations with the effective override
/// applied.
pub const EffectiveHoursOfOperations = struct {
    /// The date that the hours of operation or overrides applies to.
    date: ?[]const u8,

    /// Information about the hours of operations with the effective override
    /// applied.
    operational_hours: ?[]const OperationalHour,

    pub const json_field_names = .{
        .date = "Date",
        .operational_hours = "OperationalHours",
    };
};
