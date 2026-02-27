const aws = @import("aws");

const TimeRange = @import("time_range.zig").TimeRange;

/// Open Hours config
pub const OpenHours = union(enum) {
    daily_hours: ?[]const aws.map.MapEntry([]const TimeRange),

    pub const json_field_names = .{
        .daily_hours = "dailyHours",
    };
};
