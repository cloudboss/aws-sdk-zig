const DurationType = @import("duration_type.zig").DurationType;

/// Duration for InfluxDB parameters in Timestream for InfluxDB.
pub const Duration = struct {
    /// The type of duration for InfluxDB parameters.
    duration_type: DurationType,

    /// The value of duration for InfluxDB parameters.
    value: i64,

    pub const json_field_names = .{
        .duration_type = "durationType",
        .value = "value",
    };
};
