/// Percent or Absolute Long for InfluxDB parameters
pub const PercentOrAbsoluteLong = union(enum) {
    /// Absolute long for InfluxDB parameters.
    absolute: ?i64,
    /// Percent for InfluxDB parameters.
    percent: ?[]const u8,

    pub const json_field_names = .{
        .absolute = "absolute",
        .percent = "percent",
    };
};
