/// Specifies Auto-Tune action severity. Valid values are LOW, MEDIUM and HIGH.
pub const ScheduledAutoTuneSeverityType = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };
};
