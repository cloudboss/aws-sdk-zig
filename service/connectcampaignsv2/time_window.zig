const OpenHours = @import("open_hours.zig").OpenHours;
const RestrictedPeriods = @import("restricted_periods.zig").RestrictedPeriods;

/// Time window config
pub const TimeWindow = struct {
    open_hours: OpenHours,

    restricted_periods: ?RestrictedPeriods = null,

    pub const json_field_names = .{
        .open_hours = "openHours",
        .restricted_periods = "restrictedPeriods",
    };
};
