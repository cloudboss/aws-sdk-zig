/// Sidewalk device battery level.
pub const BatteryLevel = enum {
    normal,
    low,
    critical,

    pub const json_field_names = .{
        .normal = "NORMAL",
        .low = "LOW",
        .critical = "CRITICAL",
    };
};
